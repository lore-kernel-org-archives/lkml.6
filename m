Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeBBMui (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:50:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44284 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:49:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180202124955epoutp019fd8f7f23abacd0c41e3a68aad0e4136~PgyVMbLxs1922019220epoutp01R
X-AuditID: b6c32a46-3a9ff70000001029-c6-5a745e7285e2
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 01/12] [media] s5p-mfc: Rename IS_MFCV8 macro
Date: Fri, 02 Feb 2018 17:55:37 +0530
Message-id: <1517574348-22111-2-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRbUgTcRzH+293u9vw5JhS/yaJDIQynys6MJqFyghF3/SiUenhDpXcHLtp
        KVGzUpdEmBCVzJBcUoPZtjYfUll7AG2iK1Jb0l5EJvlQEvlQYQ/eTt994PvEjx8ulE4iMrxK
        a2D0WrpaLpIgff4DVBp73qDKXC2mZnsnUSpgmxZQD8ZaUCoUsmPUxLVljHJ+mkGpty/MIuqW
        3Y1StkAEo3qcmwLqkXsVo/zLW+bIcB/IJZRO602R8rnlqvK2ywqUP5yJyqlAI1aCqiTH1Ex1
        VR2jzzheJql8/W8C0y1kXBqI7DWCuf2tQIxD8jC8u/QBcCwlBwD8PFfeCiRbvAHgm/CCcMfk
        mb8HeGEIQM90F8YnfgI4ZU3lWESmwvWVcRHH8SQDF3ttKBcQcp7Z9TDCCXFkLjS3NAo4Rshk
        aFn7EmWCzIMP7REBv5YEF8O2rQEcF5P50PLqCNcDSZcImky/Ed6TB1ebZlCe4+DiqAvjOQHO
        Wx2A54twePMXwoeNAHaONm4LCvhyyhwtEpKx0OT/Ex2DJAFNzVLeooTmd8Ht60/A927P9vX3
        AQy6l0RtQNYFdlnBbkbHaioYNluXnc7SGrZWW5FeXqNxguiXUwoGgGWy0AdIHMhjiLJ9rEqK
        0nVsvcYHIC6UxxN9RQaVlFDT9Q2MvqZUX1vNsD6QgCPyPURTSZ5KSlbQBuYCw+gY/Y4qwMUy
        IyiwFMckjaqLNTGnnl0/Lc6qT5Rd9uZ23gEnB2VpPeE1/5DXJjhoJBxjvpykp4Nz7pHS/u/9
        dWefOALac67u5fEu93hO6EqwX3H0THfbocCGUV/0zcuOadobmh63dQSHQvmWwtgRB9WuHaZv
        RLzJHQrF3+ZMjfMjUNOela9yhK2ks1KEepb+Dxja12rhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jAd2iuJIog2vvFSxurTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8aF/2fZC17q
        V+y4K9nA+ESji5GTQ0LARGL/s+mMXYxcHEICOxkl1i7YzATh/GCUuHzsOTtIFZuAjsS396fZ
        QGwRgVSJtVvPs4IUMYMUNR14CVYkLOAgMae9kQnEZhFQlVjy9QWYzSvgIjFvw10miHUKEq9u
        rAWq5+DgFHCVWHLSFCQsBFSyYsJ9xgmMPAsYGVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl
        5+duYgSG37bDWv07GB8viT/EKMDBqMTDyyFdHCXEmlhWXJl7iFGCg1lJhHebb0mUEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6pBkYeQdMd8+a4zf0buqAk
        oubT5SMhSw6fbrn5+tO3GWstcj9vEDh648Kdxfe/hd26tNaqeZqvNr/JcvYjv25M2/j+/84Y
        4QcPOXqd2rds1F70r1zTv+JpsHjTv7OhV3Tb1rqY1k1vNvY7vInT/6whf8yH9e+E7pzX3sgZ
        HpD7Y/fx1l/3wj2K+174KbEUZyQaajEXFScCAIrN2mc7AgAA
X-CMS-MailID: 20180202124954epcas2p479ba74d07199308f7b3bcc90f87354d5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180202124954epcas2p479ba74d07199308f7b3bcc90f87354d5
X-RootMTR: 20180202124954epcas2p479ba74d07199308f7b3bcc90f87354d5
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202124954epcas2p479ba74d07199308f7b3bcc90f87354d5@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames macro IS_MFCV8 to IS_MFCV8_PLUS so that the MFCv8
code can be resued for MFCv10.10 support. Since the MFCv8 specific code
holds good for MFC v10.10 also.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c    |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 18 +++++++++---------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index 76119a8..91090fc 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -714,7 +714,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_TWOPORT(dev)		(dev->variant->port_num == 2 ? 1 : 0)
 #define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
-#define IS_MFCV8(dev)		(dev->variant->version >= 0x80 ? 1 : 0)
+#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
 
 #define MFC_V5_BIT	BIT(0)
 #define MFC_V6_BIT	BIT(1)
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
index f95cd76..a1c729c 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
@@ -399,7 +399,7 @@ int s5p_mfc_wakeup(struct s5p_mfc_dev *dev)
 	s5p_mfc_clear_cmds(dev);
 	s5p_mfc_clean_dev_int_flags(dev);
 	/* 3. Send MFC wakeup command and wait for completion*/
-	if (IS_MFCV8(dev))
+	if (IS_MFCV8_PLUS(dev))
 		ret = s5p_mfc_v8_wait_wakeup(dev);
 	else
 		ret = s5p_mfc_wait_wakeup(dev);
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 8937b0a..42e9351 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -1177,7 +1177,7 @@ void s5p_mfc_dec_init(struct s5p_mfc_ctx *ctx)
 	struct v4l2_format f;
 	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
 	ctx->src_fmt = find_format(&f, MFC_FMT_DEC);
-	if (IS_MFCV8(ctx->dev))
+	if (IS_MFCV8_PLUS(ctx->dev))
 		f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12M;
 	else if (IS_MFCV6_PLUS(ctx->dev))
 		f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12MT_16X16;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 88dbb9c..fe14479 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -74,7 +74,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
 		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
 	} else if (ctx->type == MFCINST_ENCODER) {
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
@@ -89,7 +89,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->chroma_dpb_size = ALIGN((mb_width * mb_height) *
 				S5P_FIMV_CHROMA_MB_TO_PIXEL_V6,
 				S5P_FIMV_CHROMA_DPB_BUFFER_ALIGN_V6);
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->me_buffer_size = ALIGN(S5P_FIMV_ME_BUFFER_SIZE_V8(
 						ctx->img_width, ctx->img_height,
 						mb_width, mb_height),
@@ -110,7 +110,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	switch (ctx->codec_mode) {
 	case S5P_MFC_CODEC_H264_DEC:
 	case S5P_MFC_CODEC_H264_MVC_DEC:
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_H264_DEC_V8(
 					mb_width,
@@ -167,7 +167,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
 	case S5P_MFC_CODEC_VP8_DEC:
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_VP8_DEC_V8(
 						mb_width,
@@ -182,7 +182,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_H264_ENC_V8(
 					mb_width,
@@ -215,7 +215,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV8(dev))
+		if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
 				S5P_FIMV_SCRATCH_BUF_SIZE_VP8_ENC_V8(
 					mb_width,
@@ -364,7 +364,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	ctx->luma_size = calc_plane(ctx->img_width, ctx->img_height);
 	ctx->chroma_size = calc_plane(ctx->img_width, (ctx->img_height >> 1));
-	if (IS_MFCV8(ctx->dev)) {
+	if (IS_MFCV8_PLUS(ctx->dev)) {
 		/* MFCv8 needs additional 64 bytes for luma,chroma dpb*/
 		ctx->luma_size += S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
 		ctx->chroma_size += S5P_FIMV_D_ALIGN_PLANE_SIZE_V8;
@@ -445,7 +445,7 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
 	writel(buf_addr1, mfc_regs->d_scratch_buffer_addr);
 	writel(ctx->scratch_buf_size, mfc_regs->d_scratch_buffer_size);
 
-	if (IS_MFCV8(dev)) {
+	if (IS_MFCV8_PLUS(dev)) {
 		writel(ctx->img_width,
 			mfc_regs->d_first_plane_dpb_stride_size);
 		writel(ctx->img_width,
@@ -2109,7 +2109,7 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 			S5P_FIMV_E_ENCODED_SOURCE_SECOND_ADDR_V7);
 	R(e_vp8_options, S5P_FIMV_E_VP8_OPTIONS_V7);
 
-	if (!IS_MFCV8(dev))
+	if (!IS_MFCV8_PLUS(dev))
 		goto done;
 
 	/* Initialize registers used in MFC v8 only.
-- 
2.7.4
