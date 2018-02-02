Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeBBMuC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:50:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24657 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBBMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:49:56 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180202124954epoutp037c7b5418b120b57c50d19118db1d3761~PgyTzD1Yg0618306183epoutp031
X-AuditID: b6c32a39-47fff70000000fc5-30-5a745e705351
From: Smitha T Murthy <smitha.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [Patch v8 00/12] Add MFC v10.10 support
Date: Fri, 02 Feb 2018 17:55:36 +0530
Message-id: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
X-Mailer: git-send-email 1.7.2.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmgW5BXEmUQeNBK4tb686xWhxZe5XJ
        YuaJdlaL8+c3sFucbXrDbrHp8TVWi8u75rBZ9GzYymqx9shddotlm/4wWSza+oXd4vAboOK7
        e7YxOvB6bFrVyeaxeUm9R9+WVYwenzfJeVw50sgewBrFZZOSmpNZllqkb5fAlbH3wUq2gtvC
        Ff13jjM1MN7k72Lk4JAQMJH4eUS5i5GLQ0hgB6PEgcP7mSGc74wSPz6uYupi5AQr+tPaxQKR
        2M0o0XfpDhOE84NR4vnUKSwgVWwCOhLf3p9mA7FFBFIlXq1bywpSxAxSdOvbDbAiYQEDidMb
        N7CD2CwCqhJTtl0Fi/MKuEisPrqEFWKdgsSrG2vZIew5bBJfl5VC2C4Sf9d8ZYGwhSVeHd/C
        DvGDtMSlo7YQ4XKJPX9+gl0qIdDAKDH3eCMjRMJe4sCVOWC9zAJ8Eu++9rBC9PJKdLQJQZR4
        SDSuPQs10lFi+jINkLCQQKzEyd+b2CcwSi5gZFjFKJZaUJybnlpsWGCqV5yYW1yal66XnJ+7
        iREcs1qWOxiPnfM5xCjAwajEw5sgWxwlxJpYVlyZe4hRgoNZSYR3m29JlBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHegACXKCGB9MSS1OzU1ILUIpgsEwenVAMjm3RsSPTFLwah/36eNW41C/b9
        myp8+Zr9muTnn1n2TM+bsfr7Kfnkj50cuopV//a/26itLJDtVtUSyBIVuuHopAC7j8wzpu0N
        uMu6acLpGx1K/LESbY4/8rhV73E16jB/Ndi8cf9BjYg1+qFf10/+wuw4b5fJkikhMR6bL8X/
        vndbcdmGzNXFSizFGYmGWsxFxYkAGf60PdUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsVy+t9jAd2CuJIog+XNgha31p1jtTiy9iqT
        xcwT7awW589vYLc42/SG3WLT42usFpd3zWGz6NmwldVi7ZG77BbLNv1hsli09Qu7xeE3QMV3
        92xjdOD12LSqk81j85J6j74tqxg9Pm+S87hypJE9gDWKyyYlNSezLLVI3y6BK2Pvg5VsBbeF
        K/rvHGdqYLzJ38XIySEhYCLxp7WLpYuRi0NIYCejRN/59YwQzg9GiRfT/jKCVLEJ6Eh8e3+a
        DcQWEUiVWLv1PCtIETNIUdOBl+wgCWEBA4nTGzeA2SwCqhJTtl1lAbF5BVwkVh9dwgqxTkHi
        1Y217BMYuRYwMqxilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgMqW2Htfp2MN5fEn+I
        UYCDUYmHN0G2OEqINbGsuDL3EKMEB7OSCO8235IoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3
        845FCgmkJ5akZqemFqQWwWSZODilGhjruhduMFhQHDz539WoaTzcYZwRWevTlx5eN1FY9Fbd
        gYDDl09cONzsLNfvO+PZ63OcrZ+3rJjCesl8Jf+UIMdN67P3rNx482j80qOCWTt2Gj6qcV7f
        rm9zkeNJ8B31/d+/55yNbL/oHXV94t6HB+aazbwuk3aXzSjoq9Uy/WD1o2ePyWqvPN5xXoml
        OCPRUIu5qDgRAO7jOJAlAgAA
X-CMS-MailID: 20180202124952epcas1p4735e31b16819111d6d906711e0935231
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180202124952epcas1p4735e31b16819111d6d906711e0935231
X-RootMTR: 20180202124952epcas1p4735e31b16819111d6d906711e0935231
References: <CGME20180202124952epcas1p4735e31b16819111d6d906711e0935231@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds MFC v10.10 support. MFC v10.10 is used in some
of Exynos7 variants.

This adds support for following:

* Add support for HEVC encoder and decoder
* Add support for VP9 decoder
* Update Documentation for control id definitions
* Update computation of min scratch buffer size requirement for V8 onwards

Changes since v7:
 - Addressed review comments by Hans Verkuil <hverkuil@xs4all.nl>.
 - Rebased on latest git://linuxtv.org/snawrocki/samsung.git
   for-v4.16/media/next.
 - Applied acked-by Hans on respective patches.

Smitha T Murthy (12):
  [media] s5p-mfc: Rename IS_MFCV8 macro
  [media] s5p-mfc: Adding initial support for MFC v10.10
  [media] s5p-mfc: Use min scratch buffer size as provided by F/W
  [media] s5p-mfc: Support MFCv10.10 buffer requirements
  [media] videodev2.h: Add v4l2 definition for HEVC
  [media] v4l2-ioctl: add HEVC format description
  Documentation: v4l: Documentation for HEVC v4l2 definition
  [media] s5p-mfc: Add support for HEVC decoder
  [media] s5p-mfc: Add VP9 decoder support
  [media] v4l2: Add v4l2 control IDs for HEVC encoder
  [media] s5p-mfc: Add support for HEVC encoder
  Documention: v4l: Documentation for HEVC CIDs

 .../devicetree/bindings/media/s5p-mfc.txt          |   1 +
 Documentation/media/uapi/v4l/extended-controls.rst | 410 +++++++++++++++
 Documentation/media/uapi/v4l/pixfmt-compressed.rst |   5 +
 drivers/media/platform/s5p-mfc/regs-mfc-v10.h      |  87 ++++
 drivers/media/platform/s5p-mfc/regs-mfc-v8.h       |   2 +
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |  28 ++
 drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c    |   9 +
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |  68 ++-
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |   6 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c       |  48 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c       | 557 ++++++++++++++++++++-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr.h       |  14 +
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    | 397 +++++++++++++--
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h    |  15 +
 drivers/media/v4l2-core/v4l2-ctrls.c               | 119 +++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/uapi/linux/v4l2-controls.h                 |  93 +++-
 include/uapi/linux/videodev2.h                     |   1 +
 18 files changed, 1783 insertions(+), 78 deletions(-)
 create mode 100644 drivers/media/platform/s5p-mfc/regs-mfc-v10.h

-- 
2.7.4
