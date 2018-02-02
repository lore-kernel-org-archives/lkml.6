Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeBBMwh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:52:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24745 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBBMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180202125009epoutp031f8e5bae6c36a840e5be6cec00f09f07~Pgyiiu9Tb0618306183epoutp03-
X-AuditID: b6c32a39-47fff70000000fc5-50-5a745e8026cb
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 07/12] Documentation: v4l: Documentation for HEVC v4l2
 definition
Date: Fri, 02 Feb 2018 17:55:43 +0530
Message-id: <1517574348-22111-8-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
In-reply-to: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmnm5DXEmUwfH9Nha31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK2Pup0OMBcvZ
        K76s3sjUwNjF1sXIySEhYCJxYuon5i5GLg4hgR2MEpfWHGaHcL4zSrRPeskMU/X992E2iMRu
        Rom1k/4zQTg/GCVat21nB6liE9CR+Pb+NNhcEYFUiVfr1rKCFDGDFN36doMFJCEsECbRMH8u
        I4jNIqAqcWtRI1gDr4CLxNxHD9kh1ilIvLqxFsjm4OAUcJVYctIUZI6EwAY2iYtNDawQNS4S
        fXt2Qz0hLPHq+BawegkBaYlLR20hwuUSe/78ZIHobWCUmHu8kREiYS9x4MocsHuYBfgk3n3t
        YYXo5ZXoaBOCKPGQaD/ymQ0i7Cix7UcWxL8zGCXWPT3CMoFRagEjwypGsdSC4tz01GLDAlO9
        4sTc4tK8dL3k/NxNjOB41rLcwXjsnM8hRgEORiUe3gTZ4igh1sSy4srcQ4wSHMxKIrzbfEui
        hHhTEiurUovy44tKc1KLDzFKc7AoifMGBLhECQmkJ5akZqemFqQWwWSZODilGhh1hS4n3Fhj
        fG6jwFqv+odMZ+K4+huKlCKaVz081bFW/5BYcng3j9q0i8nzTn2eKWyyrLQ4qnm3YpnqyzLT
        HUI9yWYbha7VpcteWX2lIO7yvqWnfB39p4o9VHTXseaaca9g/T2XSmFnbd7GjX6lu+9e7tT/
        1rxz4nEBY8nPdnJixaKS/Dmm1kosxRmJhlrMRcWJAKC5Z4fjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t9jAd2GuJIog/cPtC1urTvHanFk7VUm
        i5kn2lktzp/fwG5xtukNu8Wmx9dYLS7vmsNm0bNhK6vF2iN32S2WbfrDZLFo6xd2i8NvgIrv
        7tnG6MDrsWlVJ5vH5iX1Hn1bVjF6fN4k53HlSCN7AGsUl01Kak5mWWqRvl0CV8bcT4cYC5az
        V3xZvZGpgbGLrYuRk0NCwETi++/DQDYXh5DATkaJa0+ms0I4Pxgl9h/vZgKpYhPQkfj2/jRY
        h4hAqsTarefBiphBipoOvGQHSQgLhEk0zJ/LCGKzCKhK3FrUCNbAK+AiMffRQ3aIdQoSr26s
        BbI5ODgFXCWWnDQFCQsBlayYcJ9xAiPPAkaGVYySqQXFuem5xUYFhnmp5XrFibnFpXnpesn5
        uZsYgQG47bBW3w7G+0viDzEKcDAq8fAmyBZHCbEmlhVX5h5ilOBgVhLh3eZbEiXEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QD4wy9tdwnVf/nFWa8WqY1
        5fLrkJ+bmS7m7gwS0OLaee2i+sve40eWzvvFfNpPw4k5trg7ULP87x4/F/X/MpIxVhN83nHV
        XI7ddWy70rw7l2qvKn3r3FzeVuTU6zTne5n4lNWRVRxnp08IytgZt868c/Mjxa+cpRXnHj1p
        cTEvFfxX+1pvv0mcrRJLcUaioRZzUXEiALa28dA8AgAA
X-CMS-MailID: 20180202125008epcas1p1a99fa5b76765a1328147ffda49e56879
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180202125008epcas1p1a99fa5b76765a1328147ffda49e56879
X-RootMTR: 20180202125008epcas1p1a99fa5b76765a1328147ffda49e56879
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
        <CGME20180202125008epcas1p1a99fa5b76765a1328147ffda49e56879@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2 definition for HEVC compressed format which is also
known as H.265.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 Documentation/media/uapi/v4l/pixfmt-compressed.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-compressed.rst b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
index 728d7ed..abec039 100644
--- a/Documentation/media/uapi/v4l/pixfmt-compressed.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
@@ -90,3 +90,8 @@ Compressed Formats
       - ``V4L2_PIX_FMT_VP9``
       - 'VP90'
       - VP9 video elementary stream.
+    * .. _V4L2-PIX-FMT-HEVC:
+
+      - ``V4L2_PIX_FMT_HEVC``
+      - 'HEVC'
+      - HEVC/H.265 video elementary stream.
-- 
2.7.4
