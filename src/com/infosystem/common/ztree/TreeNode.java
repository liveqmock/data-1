package com.infosystem.common.ztree;

import java.util.ArrayList;
import java.util.List;

/**
 * ztree的节点属性
 *@Company 中海纪元
 *@author   hudaowan
 *@version   Fusion UCenter V1.0
 *@date   2012-2-10下午06:18:22
 *@Team 研发中心
 */

public class TreeNode {
    private String id;//当前数据id
    private String pId;//父节点ID
    private String url;//访问地址
    private String name;//节点名称
    private String ename;//节点英文名称
    private boolean checked;//如果是多选项  表示是否已经选中
    private String click;//
    private String icon;//图标
    private String iconClose;
    private String iconOpen;
    private String iconSkin;
    private String isParent;//是否是父节点
    private boolean nocheck;
    private boolean open;//是否展开
    private String target;//打开的目标
    private List<TreeNode> children = new ArrayList<TreeNode>();//子节点
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public String getClick() {
		return click;
	}
	public void setClick(String click) {
		this.click = click;
	}   
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIconClose() {
		return iconClose;
	}
	public void setIconClose(String iconClose) {
		this.iconClose = iconClose;
	}
	public String getIconOpen() {
		return iconOpen;
	}
	public void setIconOpen(String iconOpen) {
		this.iconOpen = iconOpen;
	}
	public String getIconSkin() {
		return iconSkin;
	}
	public void setIconSkin(String iconSkin) {
		this.iconSkin = iconSkin;
	}
	
	public boolean isNocheck() {
		return nocheck;
	}
	public void setNocheck(boolean nocheck) {
		this.nocheck = nocheck;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public List<TreeNode> getChildren() {
		return children;
	}
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
	public String getIsParent() {
		return isParent;
	}
	public void setIsParent(String isParent) {
		this.isParent = isParent;
	}
}
