Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeBLVuc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:50:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63108 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeBLVua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:50:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180212215029epoutp02c44f787a2bb856674d2ad0acaa163de4~SsnJ3k0dh1288312883epoutp02f
X-AuditID: b6c32a37-44bff70000001029-92-5a820c24cc50
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A820C25.1050701@samsung.com>
Date: Tue, 13 Feb 2018 06:50:29 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Revert
 "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
In-reply-to: <20180212194630.7216-2-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2t7vNKa5+ztfByNbFhAmb3jndDI0eEkr+MfSPwlK76EVN93B3
        kwwEH5k2VAzDV776IzIJlaGiqUVqiJBKs6GljqAUqTAifGBBbbtF/ved73znO5yPIyIk7wWh
        ogK9mTHp6SJS6MsfmZZFycP9KjOirXex5utsC0+z9KxDqFmt6BWeJZK/PXcIkxuG+lDyD1uY
        lshgEvIZOpcxSRl9jiG3QJ+XSF5Kz76QHRsXTcmpeI2alOppHZNIJqVq5RcLilyLSGkJXWRx
        UVqaZcmoMwkmg8XMSPMNrDmRvEpRSgUVrVYolUqFKibztDLWJbnO5DfPLAqMG4KbL+2dgnLk
        4FuRSARYBa0LWVbkK5LgUQSdfQ5vrthDsL9RLbAiH4+o7fEAwTUGESx+f+TtboixP+w3OT1O
        BD4BM/ZCN01gGQyPD/w1ciLosK96NGIcCdOfgt0aPj4F67uLHhuhi36xtSJ046P4JDj2PyI3
        DsJXYKx716MJxGmwstcr4PylcOC0eXAANoN9rZtw2/tgDWx1pLvXAu4RgnXZzuOOTILNeRl3
        SgB8nh3y5uhjYH+VyMlrENRMdhFccR/BwrKTxw3EwOZDK4/bewS2d+oE3LAYau9IOEkyNO44
        vDl8Dup76nnc6WMI3hxM8BtRWPuhtNr/p9V+KK0eRPShYMbI6vIYljLGKFhax1r0eYocg86G
        PH8VqR5FgwupUwiLEOknrn1QkSER0CVsqW4KgYggA8W/qlyUOJcuvcWYDNkmSxHDTqFYV9r3
        iNCgHIPrS/XmbEoVH62KU7p+K56iyBCxVpuUIcF5tJkpZBgjY/o3xxP5hJajgqmKzti6ofDW
        Nasyc+61V6ZxYOYpAV4HDSm+EZay4Q9Jgf2G5RRj5vGfwske2fCXhb7x6iXjNWibx+qY88Yb
        UUS6NqR8u9mfqGxECV2aJ/Li/uI0+t1cmzOi7vcsr4pYb5qcqNdgr5ast6HqZVWXw9bWK789
        fHmkbDFslOSz+TQVSZhY+g+n8D+/bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t9jQV1lnqYog4NtOhZvjk9nsri8aw6b
        xe3GFWwOzB7v911l8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6MaUfOsxY8Za04eGkuawPj
        VZYuRk4OCQETiZnL1zN3MXJxCAmsY5Toer2QDSTBKyAo8WPyPaAiDg5mAXmJI5eyQcLMAuoS
        k+Ytgqp/wChxedUSNpAaXgEticNPxEBqWARUJe5+O88OYrMBhfe/uAE2kl9AUeLqj8eMIOWi
        AhES3ScqQcIiAgESP0/1s0OMV5D4dW8TK4gtLFAicenOfKhVOxklZh7tATuHU8BC4sWc4AmM
        ArOQHDoL4dBZSA5dwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMFS3Hdbq28F4
        f0n8IUYBDkYlHt6O2Y1RQqyJZcWVuYcYJTiYlUR4/zQDhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamC0VLv9//ol9ifqCnKJIWyOKh+m9067EvE1NmzC
        /ABd/v31eeFpYfcEZUq7/Jb9KI2evI+jQnCNzonVM34+zjk6W0SpUbknPvbA0tuFPU8Fnpy3
        cWmxcyvu6m4o3nQneI59Yrb6jimqmuEL/vhG7/26JGneg0fe5pv3XnK+8OqY4rW1Ip8OHNql
        xFKckWioxVxUnAgAjtKHCFECAAA=
X-CMS-MailID: 20180212215027epcas1p1c326783a1957e34b817090e1105e06eb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180212194658epcas4p192e8d9bf50ddb48875f2dce26cfb8fd2
X-RootMTR: 20180212194658epcas4p192e8d9bf50ddb48875f2dce26cfb8fd2
References: <20180212194630.7216-1-hdegoede@redhat.com>
        <CGME20180212194658epcas4p192e8d9bf50ddb48875f2dce26cfb8fd2@epcas4p1.samsung.com>
        <20180212194630.7216-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 13일 04:46, Hans de Goede wrote:
> Redoing the charger type detection to give the usb-role-switch code time
> to properly set the role-switch is no good for mainline, since the
> usb-role-switch code is not yet in mainline (my bad, sorry).
> 
> Also once we've that code there are better ways to fix this which are
> not prone to racing as doing a retry after 2 seconds is.
> 
> This reverts commit 50082c17bb1455acacd376ae30dff92f2e1addbd.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-axp288.c | 32 ++------------------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)

Applied it.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
