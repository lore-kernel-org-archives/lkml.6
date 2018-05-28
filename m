Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeE1FY0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:24:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38640 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeE1FYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:24:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528052423epoutp0260441ec884d0e8c5280e5cb4706595fa~yt5J14ECE2144121441epoutp02m
X-AuditID: b6c32a37-a59ff70000000fec-45-5b0b9281543d
To: undisclosed-recipients:;
Mime-Version: 1.0
Subject: RE: [PATCH 08/11] PM / devfreq: Make update_devfreq() public
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180525203043.249193-9-mka@chromium.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180528052417epcms1p171d27949f7827550911218e9c46c6715@epcms1p1>
Date: Mon, 28 May 2018 14:24:17 +0900
X-CMS-MailID: 20180528052417epcms1p171d27949f7827550911218e9c46c6715
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12TbUhTURjHObt3d1drdZxWB4uyS0YmU+/W3C22CLQaZWD0oUhCb+6gontp
        d5pF0Ky0Wi+UQYkvlbWybKCurJG9rllCGUSW9SEzKypKe5nSi6XttknRp/Pj/zzP+f/P4Rya
        ULRSsXSB2Y5tZr6IoSLJi7cSlMqyynFZKT3fIPer8raM83z+KOXe+RK47sE3Uu6Y/76U6zx9
        k+K2n2yiuM5tH2Tcw8u1FBfY5wfcqe4HEi7Q/BJw5Vf9skVyg/uoGxiGf1QCQ43jAWnwNO6m
        DNfr3DLD/guNwBDwTM+UrcW6fMwbsS0Om3MtxgJznp5Zvio7LVuTmsIq2fmclokz8yasZ9Iz
        MpVLCoqCaZm4Er6oOChl8oLAJC/U2SzFdhyXbxHseiaLZVVJbIo2SaUKrup1C1SaYEsOzndd
        GSCsx8nSjs8NMgdoJ5wggkZwHjrcdYhygkhaAb0Addb3kWIhBk5DdTUvpU5A03IYhX55o0U5
        Gi5GA49aJCIrIIMcT68RIT0Z7eq9CESmoBK1Nj8jxT0J6CKRq2UUhMzkqGrnazLEU9GlhlYg
        7h8BtajHnx6SJ6Gn5/plY/zx9rHwaAwq7+kMZ45Cvd/bwnosetVfH+7firoDJySiL4IHABp+
        MhouJKO+rhpKZDlcgd5WvZeKTMJ49GL3YyrUk46+3Bj8k42AM9Cl/lpCzEbABNR0OXksvqNl
        WPY/E3ACGhjaKx3TvUdfSUI8G/naXOH+aejukfpwfgP65DwDDoCZ1X9vt/of4+q/xscB0Qgm
        Y6tgysMCa1UnCbxJKDbnJeVaTB7w58nO1XpB8/0MH4A0YMbLHcORWQopXyJsMvkAogkmRh6p
        DEpyI79pM7ZZsm3FRVjwAU3w/AeJ2Em5luAHMNuzWY1KrVZz89hUDcsyU+QV2pG1CpjH23Eh
        xlZsG5uT0BGxDrCxNe3rBv+TkSlDVxeklnL3Sq7XVGQkZtzR/bw5xz0r/etIYBCUjb5trzJJ
        E88bHdFlugvPt9ROfl6xY2dXhP7LnnZkLG9ob2qYWFqoM7py2nq3b2WHOj5h2ikp7D2id1kC
        K3I2rNzWZ312dlFif5p/vTIFejrWx69btiaweqnXzZBCPs/OJWwC/xu0CK+ZyAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203128epcas2p21a65a88fed7838221d02f6419f58bf26
References: <20180525203043.249193-9-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203128epcas2p21a65a88fed7838221d02f6419f58bf26@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Currently update_devfreq() is only visible to devfreq governors outside
>of devfreq.c. Make it public to allow drivers that adjust devfreq policies
>to cause a re-evaluation of the frequency after a policy change.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor.h | 3 ---
> include/linux/devfreq.h    | 8 ++++++++
> 2 files changed, 8 insertions(+), 3 deletions(-)

With the requirement from patch 9/11, this commit is reasonable enough.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
