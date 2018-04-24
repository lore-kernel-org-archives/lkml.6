Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeDXCdo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:33:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14182 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeDXCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:33:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180424023339epoutp03554b69e35d8256e4bb94eb4e51a09dc8~oPoYOpiiq2305023050epoutp03w
X-AuditID: b6c32a37-511ff70000001030-3c-5ade97818f06
Mime-Version: 1.0
Subject: RE: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get
 supply and clk defer.
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groek@google.com" <groek@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180419104019.24406-6-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180424023337epcms1p492088fdccfcae59946e8f3b4f343eef6@epcms1p4>
Date: Tue, 24 Apr 2018 11:33:37 +0900
X-CMS-MailID: 20180424023337epcms1p492088fdccfcae59946e8f3b4f343eef6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180424023337epcms1p492088fdccfcae59946e8f3b4f343eef6
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0hTURzHO7t321WaXKfVwaLkRoWF07s5vT3Wy4iVBpL0z0z0oie19mJ3
        sweBK8hqaiklloqPXpYV2WxuzbJY1h+VVliW1Hyh9FALssgoq103Keiv8znf8/2d34NzCEx6
        RxRB5OnNyKRntZQoGG+5FyWLPlDRq4k9W7iMee+JYl5+eStkPjTfEjG17Z1Cps55ScBcee0B
        zMExJ878HhwRMhNNDzGmubNYyHQcHBUzXe5qETNe0g6YQ7fbxWtD1FXWZ7ja5T0H1HV2i9re
        eFSknqy8g6uP3WgEamd3DaYet89PITRoVS5is5EpEumzDNl5+hwVlZSakZihjI+lo+nlTAIV
        qWd1SEVtSE6J3pin9ZVNReazWotPSmE5jopZvcpksJhRZK6BM6uoNJqWy+jYBJlc7lsV6Svk
        Sp8lE+WWOLqA8Ru2xza60ApOYDYQREAyDj4pfyK2gWBCSroAtI1O4jZAEBIyFE66wnhPGMnC
        txXFIp6lJAWtPW2YX4+BR/pbAM8iMho6mrw4f084WQbgg65CIb/ByAEMDv8qB/5sEnjq8DDu
        57nQ2eCY0oPI9XCk7FOgolmw5/KYeJo/PagNxIbDQ70dAU8o7P/eGtAj4NBYfcBfAF+OnxHw
        iSFZCuCPV78DBzFw8HnVVAsScgv0jlQIecbJRXC8pCjg2QCfFrUJeMbIBdA5Vo3xk8DIKHjN
        HTNdv/X6D/H/rIKHGwaAPzQEfvxaLJz2uGqGBH5eDD2t5wL+efBRRT1WChZW/p115T+JK/8m
        rgNYI5iNjJwuB3G0USHjWB1n0efIsgw6O5h6vEsTXKCpM9kDSAJQMyV1370aqZDN5/bqPAAS
        GBUuuT2/VyOVZLN79yGTIcNk0SLOA5S+/suwiFlZBt9X0JszaKVcoVAwcXS8kqapOZLh5Mca
        KZnDmtEuhIzINB0nIIIirGCb+3lp3lVHSMOXsKg01eerzS9qgnRGeHPn/pVvXqxLSs8/s3vH
        L4+jo8WedGV0ibc19XTis5Wnurqr12zfGn/hgHL3yY5Er8r08/5EW6iIzhx45ZYUoeMXDe7z
        2omRu5+VKT9L+8qpLYVLHGmX8NTM9BlZ92M3LesrKOjt3qwKfviOwrlcll6KmTj2D8qZ5h/S
        AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104057epcas5p311ecfdeb6cb535cd7100232d282ac323
X-RootMTR: 20180419104057epcas5p311ecfdeb6cb535cd7100232d282ac323
References: <20180419104019.24406-6-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104057epcas5p311ecfdeb6cb535cd7100232d282ac323@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lin Huang <hl@rock-chips.com>
> 
> We just return -EPROBE_DEFER error code to caller and do not
> print error message when try to get center logic regulator
> and DMC clock defer.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

I'll wait for the rebase of 3/6.

> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
