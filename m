Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeBBMwt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:52:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24724 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBBMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:08 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180202125007epoutp034dfbdfc704a10db842df4525f8b452bf~PgygCp8WA0618306183epoutp038
X-AuditID: b6c32a37-433ff70000001029-8d-5a745e7ecf10
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 06/12] [media] v4l2-ioctl: add HEVC format description
Date: Fri, 02 Feb 2018 17:55:42 +0530
Message-id: <1517574348-22111-7-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmvm5dXEmUwc7VWha31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK2PDw5+MBZ/Y
        K74eXsLYwHiFrYuRk0NCwERizu8uli5GLg4hgR2MEpv3T2CHcL4zSuxb2wNX9XzTMVaIxG5G
        iRlzHkBV/WCU2HOyA6yKTUBH4tv702C2iECqxKt1a8E6mEGKbn27AbSEg0NYwFPiymMDkBoW
        AVWJiQf/sIPYvAIuEm979zJDbFOQeHVjLTtIOaeAq8SSk6YgYyQEtrBJfNzUxgRR4yLR370D
        6jphiVfHt4DVSwhIS1w6agsRLpfY8+cnC0RvA6PE3OONjBAJe4kDV+awgNjMAnwS7772sEL0
        8kp0tAlBlHhIPFy4HWq8o8S8X/+ZIP6dwSjR0bSCfQKj1AJGhlWMYqkFxbnpqcWGBcZ6xYm5
        xaV56XrJ+bmbGMHxrGW+g3HDOZ9DjAIcjEo8vAmyxVFCrIllxZW5hxglOJiVRHi3+ZZECfGm
        JFZWpRblxxeV5qQWH2KU5mBREucNCHCJEhJITyxJzU5NLUgtgskycXBKNTBy/9dSuLdUZvoC
        o75F8dHOaeeNnr5geGWpK9onepvvnq9/Yaj1m8v+Uzae5FJYNveJvaA7o/C8F+/WFznwck9d
        b3mXRymx49o7ZqGfLiZZ9Y+URJR3M9i/8TxkG2V4M3T2x7m7ikzuNFUvFH4uVFVsw/vrbD+T
        +znbdoEXl9ySN63N+XnjloASS3FGoqEWc1FxIgDBCVea4wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t9jAd26uJIog1+7+SxurTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8aGhz8ZCz6x
        V3w9vISxgfEKWxcjJ4eEgInE803HWEFsIYGdjBLzJxt2MXIB2T8YJY5u3c0CkmAT0JH49v40
        WIOIQKrE2q3nWUGKmEGKmg68ZO9i5OAQFvCUuPLYAKSGRUBVYuLBP+wgNq+Ai8Tb3r3MEMsU
        JF7dWAtWzingKrHkpCnEXheJFRPuM05g5FnAyLCKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10v
        OT93EyMw+LYd1urbwXh/SfwhRgEORiUe3gTZ4igh1sSy4srcQ4wSHMxKIrzbfEuihHhTEiur
        Uovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamDMkTorVnoux6xmjUvb
        KuWSW+b9F99OcTt2KbdFvFDW++SyqWc3/GBx5v6oG1nk71n/QUzIdWksv8KX9SW7N87Z3+hx
        P5ZDTvTFzIlpGUmF9uyXn+8OeDlj7+YXK3ps/saXpFp/L9o3PVXzVavuy+7XxpMyy3+t3HIn
        3WbDjMk1O6bp874rFc9UYinOSDTUYi4qTgQA34mZGzoCAAA=
X-CMS-MailID: 20180202125006epcas1p13a8617e0ba18fde93d1eca712a398a2e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180202125006epcas1p13a8617e0ba18fde93d1eca712a398a2e
X-RootMTR: 20180202125006epcas1p13a8617e0ba18fde93d1eca712a398a2e
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202125006epcas1p13a8617e0ba18fde93d1eca712a398a2e@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEVC is a video coding format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 7961499..8a3c6a8 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1268,6 +1268,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_VC1_ANNEX_L:	descr = "VC-1 (SMPTE 412M Annex L)"; break;
 		case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
 		case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
+		case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break; /* aka H.265 */
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
-- 
2.7.4
