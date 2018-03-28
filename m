Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeC1OAR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:00:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:24616 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeC1OAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:00:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328140012epoutp0285abd79cf1bbb89c0bd389f1f486ce0f~gGlHOZhcE1711717117epoutp025
X-AuditID: b6c32a46-b85ff70000000fe8-12-5abb9feb16fc
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Timur Tabi <timur@tabi.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video: fsl-diu-fb: Delete an error message for a failed
 memory allocation in fsl_diu_init()
Date: Wed, 28 Mar 2018 16:00:08 +0200
Message-id: <4073804.qevdOuysOu@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <f1760f28-84f4-24d9-9cf4-ca94b0537338@tabi.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCmqe7r+bujDPa+MLO48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i6Yn6xkd2Dzudx9n8ti+YDabR9OpdlaPz5vkAliiuGxSUnMyy1KL
        9O0SuDLmPlYoeMpSMW/XFvYGxnfMXYycHBICJhJPXuxg6mLk4hAS2MEoMWdLGyOE851R4tmU
        n6wwVd3NjVBVGxglXu9azQrhfGWUmHT+MDtIFZuAlcTE9lWMILaIQIjE5/kr2UGKmAU6GCU2
        Hp/CApIQFiiS2H/lMZjNIqAqMePxL7BDeAU0JXbcuAS2TlTAS2LLvnYmEJtTwEZi2pTL7BA1
        ghI/Jt8D62UWkJfYt38qK4StI3H22DqwuyUENrBJ3O66xQZxt4vEjf//oT4Vlnh1fAs7hC0t
        8WzVRqiGZkaJbzv2QBVNYJTYs14IwraWOHz8ItQGPomOw3+BmjmA4rwSHW1QJR4SV5pvM0GE
        HSW2bjODhMo5RomVa46yT2CUnYXk7llI7p6F5O4FjMyrGMVSC4pz01OLjQqM9IoTc4tL89L1
        kvNzNzGCE4KW2w7GJed8DjEKcDAq8fAWxOyKEmJNLCuuzD3EKMHBrCTC+15jd5QQb0piZVVq
        UX58UWlOavEhRmkOFiVx3tYAlyghgfTEktTs1NSC1CKYLBMHp1QD47zHazrdepg+uvlWfWDp
        v6n/+GyRVLi5Uu+t14eV+q7ba63yK9PknKq6eo/rx8zeRPstCx3maRid3Lq3PEDS49G5/amP
        S/7dk7R9sufUlZBUq5V/7n1fvf3P3A0r3uqschV6ZsX50E9n/m2upF9bpof9/9vq6G8s3i7J
        e8/19DShdQ8VcipkhZRYijMSDbWYi4oTAbgL55EEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd1X83dHGZy+ZmNx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsFk1P1jM6sHnc7z7O5LF9wWw2j6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGXMfaxQ8JSlYt6uLewNjO+Yuxg5OSQETCS6mxuZuhi5OIQE1jFK7D+6Esr5yihxcNFx
        dpAqNgEriYntqxhBbBGBEIkZyx+zghQxC3QwSkz8twRslLBAkcT+K49ZQGwWAVWJGY9/gcV5
        BTQldty4xApiiwp4SWzZ184EYnMK2EhMm3KZHWLbOUaJ/q0LWSEaBCV+TL4HNohZQF5i3/6p
        rBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+du
        YgSG8LbDWv07GB8viT/EKMDBqMTDWxCzK0qINbGsuDL3EKMEB7OSCO97jd1RQrwpiZVVqUX5
        8UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhi5hB/5fc6VstHqUD9Y4J57
        ZsebZUKtX3+eyp6ne3LiW4c1Xy2qNdLy3G5ZLFramXhAzfmS3xnt7Phz8/IeZZ2a53rpbehf
        +fnnq1Y0f9W8Ja0j5MfUc1ynOSDn+IGGaXG+etrRge2CAb9UmRjf9Wpw7Z53/Ws5D8vhA12X
        vd90+P743224h1WJpTgj0VCLuag4EQBmWa0sXQIAAA==
X-CMS-MailID: 20180328140011epcas2p3c7799af303d73e54edee173f420f3570
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171127173815epcas4p35a349f9b327e25953d5eb67563f288eb
X-RootMTR: 20171127173815epcas4p35a349f9b327e25953d5eb67563f288eb
References: <39d05a48-e649-fb88-0e86-4f7528fd67f8@users.sourceforge.net>
        <CGME20171127173815epcas4p35a349f9b327e25953d5eb67563f288eb@epcas4p3.samsung.com>
        <f1760f28-84f4-24d9-9cf4-ca94b0537338@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 11:31:10 AM Timur Tabi wrote:
> On 11/27/17 3:00 AM, SF Markus Elfring wrote:
> > From: Markus Elfring<elfring@users.sourceforge.net>
> > Date: Mon, 27 Nov 2017 09:56:09 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>
> 
> Acked-by: Timur Tabi <timur@tabi.org>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
