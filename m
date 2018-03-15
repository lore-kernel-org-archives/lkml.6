Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeCONgB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:36:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61889 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCONf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:35:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180315133557epoutp0186af78d0a44759aa1648845fdd3930d7~cG3OpjOTJ3020230202epoutp01o
X-AuditID: b6c32a47-187ff7000000100c-ff-5aaa76bd7eb8
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 16/47] video/logo: remove obsolete logo files
Date: Thu, 15 Mar 2018 14:35:53 +0100
Message-id: <152115724.aaUxBFlits@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180314153603.3127932-17-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCmqe7eslVRBvMmy1v8nXSM3eLK1/ds
        Fif6PrBaXN41h82BxeP3r0mMHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJVxancLa0Erc8X8
        Z4uZGxgPMHUxcnJICJhInLi9laWLkYtDSGAHo8ThFbNYIZzvjBIvN/5lhanat+QsM0RiA6PE
        hY/NjBDOV0aJ97ceglWxCVhJTGxfxQhiiwgoSkx98Qyog4ODWSBBYvciM5CwsICjxOxDs1lA
        bBYBVYl5N2aDlfAKaEtMmhEPEhYV8JLYsq8d7DpOATOJbzdPgk3nFRCU+DH5Hlgrs4C8xL79
        U1khbB2Js8fWgZ0jIbCATWJlw2dGiKNdJKbM+g/1gLDEq+Nb2CFsaYlnqzZCNTQzSnzbsYcZ
        IjGBUWLPeiEI21ri8PGLUBv4JDoO/2UHOVRCgFeiow2qxENi/qU2Zoiwo8S9WUyQINnCKLH/
        1kT2CYyys5DcPQvJ3bOQ3L2AkXkVo1hqQXFuemqxUYGxXnFibnFpXrpecn7uJkZwxGu572Dc
        ds7nEKMAB6MSD+8N5ZVRQqyJZcWVuYcYJTiYlUR4fQpWRQnxpiRWVqUW5ccXleakFh9ilOZg
        URLnbQ1wiRISSE8sSc1OTS1ILYLJMnFwSjUw+u1QrWnZyy5rePBPs4f45r1WO4+alTqUuO7s
        P8wV51Gpv+vgBGu+LuYl9Vp/Zovn10uc/vRhT0WUj9uOtu8lxsxHk0R8vG7PPHHSYdJ/0dMp
        DIud8yxyt3je3FV6xmh9csD6HZkvfhlHnayaGFZS9uKJSvSBZT86FpSZL+85sVDSozarOJBb
        iaU4I9FQi7moOBEAFaXGufQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t9jQd09ZauiDHoP81v8nXSM3eLK1/ds
        Fif6PrBaXN41h82BxeP3r0mMHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJVxancLa0Erc8X8
        Z4uZGxgPMHUxcnJICJhI7FtylrmLkYtDSGAdo8SLv+tZIJyvjBJ3d7YzglSxCVhJTGxfBWaL
        CChKTH3xjBnEZhZIkFjxtp0VxBYWcJSYfWg2C4jNIqAqMe/GbKAaDg5eAW2JSTPiQcKiAl4S
        W/a1gy3mFDCT+HbzJCvEri2MEjNP3QabzysgKPFj8j0WiPnyEvv2T2WFsLUk1u88zjSBkX8W
        krJZSMpmISlbwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMEi3Hdbq38H4eEn8
        IUYBDkYlHl4DtZVRQqyJZcWVuYcYJTiYlUR4fQpWRQnxpiRWVqUW5ccXleakFh9ilOZgURLn
        5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpg9Pogt2HZxke6Pluz2XXPyXpsVUg5NunRCfvJZhwO
        scuPGnwRX3Rvm5jH65ffnmid2XI5Z3votnmvQ9XUQ74cVK/673mLg9XQ6AfLgYySXs+dxzQU
        76S99H/lef/J3FPP/ojwdZ7KV+9cknP7/fkLbxf72Pd0SDr++PThWHjwzCV9VcdXLnSfvEyJ
        pTgj0VCLuag4EQBSLECgTgIAAA==
X-CMS-MailID: 20180315133556epcas2p4c17d6fbf528039db2f23c80f60645707
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180314154248epcas5p3a3e04fa555f7923f63eafd6673654f2f
X-RootMTR: 20180314154248epcas5p3a3e04fa555f7923f63eafd6673654f2f
References: <20180314153603.3127932-1-arnd@arndb.de>
        <CGME20180314154248epcas5p3a3e04fa555f7923f63eafd6673654f2f@epcas5p3.samsung.com>
        <20180314153603.3127932-17-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 04:35:29 PM Arnd Bergmann wrote:
> The blackfin and m32r architectures are getting removed, so it's
> time to clean up the logos as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
