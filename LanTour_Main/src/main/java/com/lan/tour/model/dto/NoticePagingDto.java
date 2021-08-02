package com.lan.tour.model.dto;

public class NoticePagingDto {
	private String category;
	private String keyword;
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	private int display_board = 10;	 // 한 페이지당 출력할 게시글의 수
	private int display_page = 5;		 // 한 블록당 출력할 페이지 수
	
	private int nowPage;	// 현재 페이지
	private int prevPage; // 이전 페이지
	private int nextPage; // 다음 페이지
	private int totalPage; // 전체 페이지 갯수

	private int totalBlock; // 전체 블록 갯수
	private int nowBlock; // 현제 페이지 블록
	private int prevBlock; // 이전 페이지 블록
	private int nextBlock; // 다음 페이지 블록

	private int pageBegin; // 해당 페이지의 첫번째 게시글 no
	private int pageEnd; // 해당 페이지의 마지막 게시글 no

	private int blockBegin; // 현재 블록의 시작 페이지 번호
	private int blockEnd; // 현재 블록의 마지막 페이지 번호
	
	public NoticePagingDto() {
	}
	
	public NoticePagingDto(int count, int nowPage) {
		nowBlock = 1;
		this.nowPage = nowPage;
		setTotalPage(count);
		setPageRange();
		setTotalBlock();
		setBlockRange();
	}
	public NoticePagingDto(int count, int nowPage, String keyword, String category) {
		this.keyword = keyword;
		this.category = category;
		nowBlock = 1;
		this.nowPage = nowPage;
		setTotalPage(count);
		setPageRange();
		setTotalBlock();
		setBlockRange();
	}
	

	public void setBlockRange() {
		nowBlock = (int) Math.ceil((nowPage - 1) / display_page) + 1;
		blockBegin = (nowBlock - 1) * display_page + 1;
		blockEnd = blockBegin + display_page - 1;
		if (blockEnd > totalPage) {
			blockEnd = totalPage;
		} 
		prevPage = (nowPage == 1) ? 1 : (nowBlock - 1) * display_page;
		nextPage = (nowBlock > totalBlock) ? (nowBlock * display_page) : (nowBlock * display_page) + 1;
		if (nextPage >= totalPage) {
			nextPage = totalPage;
		}
	}
	
	// 페이지 범위 계산
	public void setPageRange() {
		pageBegin = (nowPage - 1) * display_board + 1;
		pageEnd = pageBegin + display_board - 1;
	}

	public int getDisplay_board() {
		return display_board;
	}

	public void setDisplay_board(int display_board) {
		this.display_board = display_board;
	}

	public int getDisplay_page() {
		return display_page;
	}

	public void setDisplay_page(int display_page) {
		this.display_page = display_page;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int count) {
		this.totalPage = (int) Math.ceil(count/ (double)display_board);
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock() {
		this.totalBlock = (int) Math.ceil(totalPage / (double) display_page);
	}

	public int getNowBlock() {
		return nowBlock;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	
}
