package fileupload;

public class MyFileDTO {
	// 멤버 변수
	private String idx;
	private String title;	// 제목
	private String cate;	// 카테고리
	private String ofile;	// 원본 파일명 - original file name
	private String sfile;	// 저장된 파일명 - save file name
	private String postdate;// 등록 날짜
	
	// 게터 / 세터
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	
	@Override
	public String toString() {
		return "MyFileDTO [idx=" + idx + ", title=" + title + ", cate=" + cate + ", ofile=" + ofile + ", sfile=" + sfile
				+ ", postdate=" + postdate + "]";
	}
}
