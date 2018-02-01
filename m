Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeBAIXs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:23:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36607 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBAIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:23:40 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180201082339epoutp0161cf60d24a0b4c954f4193137e00dde9~PJgjjvD1I0139301393epoutp01X
X-AuditID: b6c32a39-467ff70000000fc5-cc-5a72ce8a3d69
From: Andi Shyti <andi.shyti@samsung.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>,
        Andi Shyti <andi@etezian.org>
Subject: [PATCH 0/2] Licensing fixes and updates for the mms114 driver
Date: Thu, 01 Feb 2018 17:23:18 +0900
Message-id: <20180201082320.24031-1-andi.shyti@samsung.com>
X-Mailer: git-send-email 2.15.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmnm7XuaIogy/zdC22H3nGarH4x3Mm
        i8OLXjBatD/qZLW4+ekbq8XlXXPYLCauv8fqwO5xfcknZo+ds+6ye3yfcYbRo2/LKkaPz5vk
        AlijUm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
        UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqRRsaGukZGpjrGRkZ6ZkYx1oZmQKVJKRm7H68
        iK1gM3PFoV+3WBsYLzN1MXJySAiYSJzd2sgGYgsJ7GCUWPpduYuRC8j+zijR3PgLrmjS+z4m
        iMQGRon5nZ+hnE+MEpe2LgRrZxPQlGi6/QPMFhFIkFje+YMZpIhZYCmjxMLmpSwgCWEBN4lX
        k2aB2SwCqhKPFx4Hs3kFrCWuz1vNCrFOXmLCliYWkGYJgY+sEhOm/Ie6w0Vi14MX7BC2sMSr
        41uAbA4gW1ri0lFbiHAzo8S228kQvRMYJT7t/QrVayzxbGEXmM0swCfx7msPK0Qvr0RHmxCE
        6SFx6ZEYhOkocWZ2LiRUYiVuvXjIOoFRcgEjwypGsdSC4tz01GLDAlO94sTc4tK8dL3k/NxN
        jOB0oWW5g/HYOZ9DjAIcjEo8vBMuFEYJsSaWFVfmHmKU4GBWEuF9s68oSog3JbGyKrUoP76o
        NCe1+BCjKTAwJjJLiSbnA1NZXkm8oYmlgYmZETD2LQ0NlcR5AwJcooQE0hNLUrNTUwtSi2D6
        mDg4pRoYFR7bCy623L7482z+2WVve9vfuOT2ic3fZrDFiTmI/V9CzJOt//NTqqN3Lrgg/k5v
        F4/Bk4TgSIN4ZeWOJ+1yfTwfvZ3iLha+mzuFa/uSTSscGCuSefzEN26+W6F8rEdj5ZnvD3/c
        Kb80/WjqqyUR+tKmN37NWPzUortv2Yy1RU+i18+9uKSkRYmlOCPRUIu5qDgRANXCNcstAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsVy+t9jQd2uc0VRBk/WC1psP/KM1WLxj+dM
        FocXvWC0aH/UyWpx89M3VovLu+awWUxcf4/Vgd3j+pJPzB47Z91l9/g+4wyjR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGXsfryIrWAzc8WhX7dYGxgvM3UxcnJICJhITHrfB2RzcQgJrGOU
        aPh5FMr5xCixbeIlRpAqNgFNiabbP9hAbBGBBImza18wgxQxCyxllNh56z5YkbCAm8SrSbNY
        QGwWAVWJxwuPg9m8AtYS1+etZoVYJy8xYUsTywRGrgWMDKsYJVMLinPTc4uNCgzzUsv1ihNz
        i0vz0vWS83M3MQIDY9thrb4djPeXxB9iFOBgVOLhfXGpMEqINbGsuDL3EKMEB7OSCO+bfUVR
        QrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTA2y6U+vBB9
        7scby9qpT/gCgp8Ub2wLWtWgvPeLTPj0n3+1xI9MfB2uxpPhuifTbEflkeUxgueKjmy53OU4
        T0bNO+9vp6v2Np4Ob1XexFylmmeXFd6fsuyLf9EYdD9j068WlXU3Hxyf3Rwffnn/jp0GzId3
        sk35XT5hZmnOE5Ger1KahVlSAWJKLMUZiYZazEXFiQCWdHTaCAIAAA==
X-CMS-MailID: 20180201082338epcas1p43bf7d96c63fdc5bf905528e45d227d8b
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180201082338epcas1p43bf7d96c63fdc5bf905528e45d227d8b
X-RootMTR: 20180201082338epcas1p43bf7d96c63fdc5bf905528e45d227d8b
References: <CGME20180201082338epcas1p43bf7d96c63fdc5bf905528e45d227d8b@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I will send this two as a new patchset. The first one is the
messed SPDX patch that you reverted, the second one is about the
license incohorency that Marcus has pointed out.

Andi

Andi Shyti (2):
  Input: mms114 - add SPDX identifier
  Input: mms114 - fix license module information

 drivers/input/touchscreen/mms114.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

-- 
2.15.1
