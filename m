Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBBMxB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:53:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24708 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBBMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180202125004epoutp033177926928f4c4415b62642bcca640da~PgydzLEXe0618306183epoutp036
X-AuditID: b6c32a36-c91ff70000001028-5a-5a745e7c8939
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 05/12] [media] videodev2.h: Add v4l2 definition for HEVC
Date: Fri, 02 Feb 2018 17:55:41 +0530
Message-id: <1517574348-22111-6-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmrm5NXEmUwbU53Ba31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK+Po+9fMBbM5
        Kv4efMfWwPiJrYuRk0NCwERiT38zaxcjF4eQwA5GiY7u/YwQzndGiaZNz4EyHGBV32/pQMR3
        M0os33GcDcL5wSjx6MpDZpBRbAI6Et/enwYbKyKQKvFq3VqwscwgRbe+3WABSQgLeEss7j7K
        CmKzCKhKvN7yDayBV8BF4s7HNewQNylIvLqxlh1kM6eAq8SSk6YgcyQEtrBJrGl7xQxR4yLx
        accNqHphiVfHt7BDXCotcemoLUS4XGLPn58sEL0NjBJzjzcyQiTsJQ5cmQN2D7MAn8S7rz1Q
        X/JKdLQJQZR4SOx+uQ5qvKPEjllTwc4UEpjBKPFlpswERqkFjAyrGMVSC4pz01OLDQuM9IoT
        c4tL89L1kvNzNzGCo1nLbAfjonM+hxgFOBiVeHgTZIujhFgTy4orcw8xSnAwK4nwbvMtiRLi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOGxDgEiUkkJ5YkpqdmlqQWgSTZeLglGpgXL/k1/Z0jwaf
        TiMVyzUX095cFJrufcJCNllEYcEkswQ2m4h3y1WPfvl+e5vjixvu4gU9r21eeFnPWhq12enB
        1k6G/o9ZSe0/nTbM2bvlkJr7nPnrnAW/v/ytvHHL0mKH4OyWStsKp74JAd67RLzDs62LNQKY
        PtYalGgddbvYKz93+zMPnrkdSizFGYmGWsxFxYkA3uMTvuICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t9jAd3quJIogyWrTSxurTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8bR96+ZC2Zz
        VPw9+I6tgfETWxcjB4eEgInE91s6XYycHEICOxkllsyxgbB/MErM6zMAsdkEdCS+vT/NBmKL
        CKRKrN16nrWLkYuDGaSm6cBLdpCEsIC3xOLuo6wgNouAqsTrLd/AGngFXCTufFwDViMhoCDx
        6sZadpC9nAKuEktOmkLscpFYMeE+4wRGngWMDKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS
        83M3MQJDb9thrb4djPeXxB9iFOBgVOLhTZAtjhJiTSwrrsw9xCjBwawkwrvNtyRKiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkbBRzf/97qHRX4t1P2s
        zZaRGqFxRorrfYOI6ZPA75dFOTSSPJOmmU4Sf3WJq8ioZmfS6wXn11zWv2T1UVD7+b+bM5zl
        auPaNZS9hTi+vXOcZBhz8WRDF++cK48S39xs9dTlvr1Q7VTiCc1ViQfcffVzM6o0D+/0n7Tq
        2PHeopluFxi5VZ1uHFJiKc5INNRiLipOBABI+7NnOQIAAA==
X-CMS-MailID: 20180202125003epcas1p46bd17cbd13b0431d7680e72f4c2be057
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180202125003epcas1p46bd17cbd13b0431d7680e72f4c2be057
X-RootMTR: 20180202125003epcas1p46bd17cbd13b0431d7680e72f4c2be057
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202125003epcas1p46bd17cbd13b0431d7680e72f4c2be057@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2 definition for HEVC compressed format

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 include/uapi/linux/videodev2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1c095b5..ba937f5 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -635,6 +635,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_VC1_ANNEX_L v4l2_fourcc('V', 'C', '1', 'L') /* SMPTE 421M Annex L compliant stream */
 #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
 #define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
+#define V4L2_PIX_FMT_HEVC     v4l2_fourcc('H', 'E', 'V', 'C') /* HEVC aka H.265 */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.7.4
