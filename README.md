# bt_tree
> I've implemented a behavior tree template to make it easier to understand the underlying principles of behavior trees, and I've also designed a scripting language [tt_bt](https://github.com/peitianyu/tt_bt) to make it easier to use and more elegant.

![C++](https://img.shields.io/badge/-C++-333333?style=flat&logo=c%2B%2B&logoColor=00599C)
![Git](https://img.shields.io/badge/-Git-333333?style=flat&logo=git)
![GitHub](https://img.shields.io/badge/-GitHub-333333?style=flat&logo=github)
![Markdown](https://img.shields.io/badge/-Markdown-333333?style=flat&logo=markdown)

## Build

```sh
git clone https://github.com/peitianyu/bt_tree.git

cd bt_tree
./rebuid.sh
```

## Usage example

```c++
#include "core/tt_test.h"
#include "core/tt_log.h"
#include "common/behavior_tree.h"

class PrintValue : public BehaviorTree {
public:
    PrintValue(const std::string &name, const std::string &key)
        : BehaviorTree(name, NODE_ACTION), m_key(key) {}

    virtual void run() override {
        LOG("PrintValue: ", m_key);
        set_status(BT_SUCCESS);
    }
private:
    std::string m_key;
};

class SwitchIndex : public BehaviorTree {
public:
    SwitchIndex(const std::string &name)
        : BehaviorTree(name, NODE_ACTION) {}

    virtual void run() override {
        m_data[m_name] = std::make_pair<std::string, std::string>("switch_index", "1");
        set_status(BT_SUCCESS);
    }
};

class RepeatNode : public BehaviorTree
{
public:
    RepeatNode(const std::string &name, int cnt) 
        : BehaviorTree(name, NODE_ACTION), m_cnt(cnt) {}
    
    virtual void run() override {
        m_data[m_name] = std::make_pair<std::string, std::string>("need_repeat", "1");
        if(m_cnt--) m_data[m_name].second = "1";
        else        m_data[m_name].second = "0"; 

        set_status(BT_SUCCESS);  
    }
protected:
    int m_cnt;
};

JUST_RUN_TEST(behavior_tree, test)
TEST(behavior_tree, test)
{
    LOG_TEST("----------------------------behavior_tree--------------------------");

    LOG_TEST("-------------------------sequence test--------------------------");
    BehaviorTree* bt_sequence = new BehaviorTree("", NODE_SEQUENCE);
    bt_sequence->add_child(new PrintValue("print_value_1", "key1"));
    bt_sequence->add_child(new PrintValue("print_value_2", "key2"));
    bt_sequence->update();

    LOG_TEST("----------------------------fallback test----------------------------");

    BehaviorTree* bt_fallback = new BehaviorTree("", NODE_FALLBACK);
    bt_fallback->add_child(new PrintValue("print_value_3", "key3"));
    bt_fallback->add_child(new PrintValue("print_value_4", "key4"));
    bt_fallback->update();

    LOG_TEST("----------------------------switch test----------------------------");

    BehaviorTree* bt_switch = new BehaviorTree("", NODE_SWITCH);
    bt_switch->add_child(new SwitchIndex("switch_choice"));
    bt_switch->add_child(new PrintValue("print_value_5", "key5"));
    bt_switch->add_child(new PrintValue("print_value_6", "key6"));
    bt_switch->update();

    LOG_TEST("----------------------------repeat test----------------------------");

    BehaviorTree* bt_repeat = new BehaviorTree("", NODE_REPEAT);
    bt_repeat->add_child(new RepeatNode("print_choice", 3));
    bt_repeat->add_child(new PrintValue("print_value_7", "key7"));
    bt_repeat->update();

    LOG_TEST("----------------------------sub tree test----------------------------");

    BehaviorTree* root = new BehaviorTree("root", NODE_SEQUENCE);
    root->add_child(bt_sequence);
    root->add_child(bt_fallback);
    root->add_child(bt_switch);
    BehaviorTree* bt_repeat1 = new BehaviorTree("", NODE_REPEAT);
    bt_repeat1->add_child(new RepeatNode("print_choice", 3));
    bt_repeat1->add_child(new PrintValue("print_value_7", "key7"));
    root->add_child(bt_repeat1);
    root->update();
}
```

## Development setup

Have no development setup, just !!!`rebuild.sh`!!!

## Meta

Pei tianyu – [wechat](pty2182) – 1216582161@qq.com

Distributed under the MIT license. See LICENSE for more information.

[https://github.com/peitianyu/bt_tree](https://github.com/peitianyu/bt_tree)

## Contributing

1. Fork it (<https://github.com/peitianyu/bt_tree/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
