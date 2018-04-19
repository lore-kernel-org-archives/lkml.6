Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeDSKl6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:41:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53432 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeDSKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:41:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180419104150euoutp025ea4b2c7193df65d154ece6bce064a49~m0EMQDjok2385923859euoutp02H
X-AuditID: cbfec7f2-5ffe19c000011644-32-5ad8726bc7e1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL V3] Thermal SoC management updates for v4.17-rc1
Date: Thu, 19 Apr 2018 12:41:42 +0200
Message-ID: <13169679.AINr0uuryx@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180418141027.GA3303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned3sohtRBs8Oc1rMv3KN1WL5vn5G
        i8u75rBZfO49wmjx5GEfmwOrx85Zd9k9Fu95yeTxeZNcAHMUl01Kak5mWWqRvl0CV8bsW8fZ
        Ck5qVxz6c5OxgXGiVhcjB4eEgInE2hXKXYxcHEICKxglrq58zA7hfGGUePrnMRuE85lR4ter
        EywwHZuOmULElzNKnNz6ngnC+cAosXPvDuYuRk4ONgEriYntqxhBbBEBLYkTl7aDFTELLGOU
        WHevC6xIWMBd4vPBzUwgNouAqkT3sj9gNi9Qw/t1N1lBbFEBL4kt+9rB4pxAQ5een8wIUSMo
        cXLmExYQm1lAW2LZwtfMELaexI2pU8DOlhBoZ5d49WwNO0hCQsBF4uvkq1C2sMSr41ugbBmJ
        /zvnM0E0NDNKfNuxhxkiMYFRYs96IQjbWuLw8YusELatxKb5T9ghYcEnceOtIMRiPolJ26Yz
        Q4R5JTraoDrVJDYs28AGs6pr50qo6R4SU26/ZJnAqDQLyTuzkLwzC8k7CxiZVzGKp5YW56an
        FhvmpZbrFSfmFpfmpesl5+duYgSmkdP/jn/awfj1UtIhRgEORiUe3gT/61FCrIllxZW5hxgl
        OJiVRHjFzwKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUa
        GPfpXZnx4YN0yPwz712PJrw6pytyMXb2XYELpgYy7bde3vj4kC1DcV6PiIXnawnnR21p6a4P
        dYViznmFpe/22vuId+JXYYkFGzM77zdxK7q1CgRwuy+W93JnPpKWtFmm/MmJ8stV6RI+/88y
        GrS0ZqflSZd6CBrG2jzdaZ7WXTFzhnTGLulqJZbijERDLeai4kQAIMdI5B8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xu7qZRTeiDE7vNbSYf+Uaq8Xyff2M
        Fpd3zWGz+Nx7hNHiycM+NgdWj52z7rJ7LN7zksnj8ya5AOYoPZui/NKSVIWM/OISW6VoQwsj
        PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzdb7cwFXTLVazcdIq9gXGfeBcjB4eE
        gInEpmOmXYxcHEICSxklrm7dwwwRl5E4vr6si5ETyBSW+HOtiw2i5h2jxNKNx9hAEmwCVhIT
        21cxgtgiAloSJy5tZwIpYhZYxCgx7dZLVpCEsIC7xOeDm5lAbBYBVYnuZX/AbF6ghvfrboLV
        iAp4SWzZ1w4W5wQauvT8ZEaIbb2MErPvL4BqEJQ4OfMJC4jNLKAtsWzha2YIW0/ixtQpbBMY
        BWchKZuFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNj27GfW3Ywdr0LPsQo
        wMGoxMOb4H89Sog1say4MvcQowQHs5IIr/hZoBBvSmJlVWpRfnxRaU5q8SFGU6DvJjJLiSbn
        AyM3ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo0TLR8OD0bcV
        tPUfpKwW4j3okXs1LVLTrVBe58FJD5MLL/e2HFn6asqTh3/yrJckRskENIU937Jt1/+forfe
        FHdsrpt3S4rh1vRGzpyej9OVd6882pawQ2vuVN1bXruyJxq6fMu53Gys9+hg76fDl7asnX8g
        /uw+ZvsNJpnVC888vrQ81yXofocSS3FGoqEWc1FxIgBIYmGJpAIAAA==
X-CMS-MailID: 20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd
X-Msg-Generator: CA
X-MTR: 20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd
X-RootMTR: 20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd
References: <20180414183051.GA27921@localhost.localdomain>
        <1524037889.2553.13.camel@intel.com>
        <20180418141027.GA3303@localhost.localdomain>
        <CGME20180419104145eucas1p2e64408e3340d5af7731765df0e82f1cd@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JAg1C1021108


Hi,

On Wednesday, April 18, 2018 07:10:30 AM Eduardo Valentin wrote:
> Hello,
> 
> On Wed, Apr 18, 2018 at 03:51:29PM +0800, Zhang Rui wrote:
> > Hi, Eduardo,
> > 
> > On å…­, 2018-04-14 at 11:30 -0700, Eduardo Valentin wrote:
> > > Hello Linus,
> > > 
> > > Please find thermal-soc changes for v4.17-rc1.
> > > Rui asked me to send the pull request directly to you
> > > as we are close to the end of the merge window.
> > > Essentially this pull removes the series that caused
> > > warning regression. I will work with the developer
> > > to get that fixed later on, but I am still sending
> > > the other few patches that are unrelated to that.
> > > Let me know if this causes any issues and can still
> > > be pulled.
> > > 
> > > Changelog:
> > > - New i.MX7 thermal sensor
> > > - Mediatek driver now supports MT7622 SoC
> > > - Removal of min max cpu cooling DT property
> > > 
> > > Differences in V3:
> > > - Rebased on top current linus/master, to avoid and merge issues
> > > from previous pulled thermal code.
> > > 
> > > Differences in V2:
> > > - Reordered the patches to drop exynos changes for now until we get
> > > agreement on the fix on that driver for the compilation warns
> > > caused by the confusing conversion functions.
> > > 
> > > 
> > > The following changes since commit
> > > 48023102b7078a6674516b1fe0d639669336049d:
> > > 
> > > Â  Merge branch 'overlayfs-linus' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs (2018-04-
> > > 13 16:55:41 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > > Â  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > > thermal linus
> > > 
> > > for you to fetch changes up to
> > > 15a32df1918259be6c23fc36014fc26ee66c836c:
> > > 
> > > Â  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
> > > (2018-04-14 09:37:55 -0700)
> > > 
> > This pull request does not catch this merge window.
> > So do you want to split it into 2 separate pull requests, one for 4.17-
> > rc and another for 4.18-rc1?
> 
> OK. Yeah, I am fine with that.
> 
> > 
> > > ----------------------------------------------------------------
> > > Anson Huang (1):
> > > Â Â Â Â Â Â thermal: imx: add i.MX7 thermal sensor support
> > > 
> > > Bartlomiej Zolnierkiewicz (1):
> > > Â Â Â Â Â Â dt-bindings: thermal: remove no longer needed samsung thermal
> > > properties
> > > 
> > > Sean Wang (2):
> > > Â Â Â Â Â Â dt-bindings: thermal: add binding for MT7622 SoC
> > > Â Â Â Â Â Â thermal: mediatek: add support for MT7622 SoC
> > > 
> > > Viresh Kumar (1):
> > > Â Â Â Â Â Â dt-bindings: thermal: Remove "cooling-{min|max}-level"
> > > properties
> > > 
> > IMO, together with the refreshed exynos fixes, the one from Viresh and
> > the one fromÂ Bartlomiej can be queued for 4.17-rc, and the others have
> > to wait until next merge window.
> > 
> 
> Correct, the new chip support will need to wait for the next merge
> window. I have already split the patches into the two categories.
> The patches removing stuff are in my -fixes branch. All the other adding
> new chip support are in my -linus branch.
> 
> Now, Do you have anything for this -rc2 ? If not, I will send directly
> to Linus the stuff in my -fixes branch. Let me know.

What about refreshed Exynos patches (https://lkml.org/lkml/2018/4/16/256)?

Fixes from Marek (first two patches) are quite critical (without them
booting with thermal enabled triggers critical temperature handling on
Exynos4210 SoC).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
