Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeFDN77 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:59:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41125 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeFDN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180604135954euoutp019ebd4754921061d9fb1b4f1fe01c6cfd~0_cQgsU_x2381523815euoutp01L
X-AuditID: cbfec7f2-1c1ff70000011644-80-5b1545d8376e
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: Re: Regression in Linux next again
Date: Mon, 04 Jun 2018 15:59:17 +0200
Message-id: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <20180530144505.GB5705@atomide.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7djPc7o3XEWjDd6+NLSY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8aJV+fZCg6wVzT+v8vUwNjD1sXIySEhYCJx5NgW
        5i5GLg4hgRWMEiuWt7NAOJ8ZJSY9fs8IU7Xv41dWiMQyRomjvY+hqv4zSkw83wI0i4ODTUBL
        Yk17PEiDiICrxPees2A1zAI3GCWuHDoPNklYQFuibf5csN0sAqoSjzYuZwGxeQVcJJbdvcQO
        sU1O4ua5TmYQm1PAQGL2qf1gmyUEJrBJPLp5GKrIRaKzcxGULSzx6vgWKFtGorPjIBOEnS/R
        +uwxVLxCYl/vaVYI21ri8PGLYDazAJ/EpG3TmUEekBDglehoE4Io8ZA4fmctO8STzYwSs2Zc
        YZ3AKLmAkWEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYESe/nf80w7Gr5eSDjEKcDAq
        8fBqWIlGC7EmlhVX5h5ilOBgVhLhPW0BFOJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQ
        nliSmp2aWpBaBJNl4uCUamCcc/Vk5iLGUL+75wUdGbdcbT40O+Bg2YNZ6Ucyl3xtfhEl7ucU
        0dZxn2nVMg1rW//6t/YFXukP9vPedZ5hvKiM865R4c/J6zo3vkqRYv28K4jrla+1FttK9W1b
        7T72lnc//8nKd2l/pf+9vawZt57riAq7qq++qzu50HD9ptNmVr9bXe/HWzxXYinOSDTUYi4q
        TgQAboAF2MQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd3rrqLRBtsW2lhMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+PEq/NsBQfYKxr/32VqYOxh62Lk5JAQMJHY9/Er
        K4gtJLCEUWLPVd0uRi4gu5FJ4sXkh8xdjBwcbAJaEmva40FqRARcJb73nGUBqWEWuMUosf7V
        URaQhLCAtkTb/LlgQ1kEVCUebVwOFucVcJFYdvcSO8QyOYmb5zqZQWxOAQOJ2af2Qy3Wlzi5
        dh/LBEaeBYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJDaduxn5t3MF7aGHyIUYCDUYmH
        V8NKNFqINbGsuDL3EKMEB7OSCO9pC6AQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJ
        JanZqakFqUUwWSYOTqkGxmld7Nvbiu5qvpiZ+Uvy9IKd9lss1l0VvRqkc1bu5ZtNrWFc1xbw
        3s16LvDJZ+XcDfkzUgL7VK5XrpuqF2Jlnca/aUGJq0na48DytqK6K51xJ86xsnZ91n/MKyjZ
        8WqS/lThDUt1uOLErL5Pzpp72+I094poydhj4Tvn52a5F1f7rX3851tEjRJLcUaioRZzUXEi
        ANb/x6UhAgAA
X-CMS-MailID: 20180604135952eucas1p292f7bcec405e6a1a6261031df36cad32
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135952eucas1p292f7bcec405e6a1a6261031df36cad32
References: <20180530144505.GB5705@atomide.com>
        <CGME20180604135952eucas1p292f7bcec405e6a1a6261031df36cad32@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset contains previous two reverted patches. They were split
in order to make it easier to bisect, where the problem lies. It adds
also some simple debugs, which should help us track down the problem.

Tony, please apply this patchset and test it on your Beaglebone. It'd be
great if you could try to find out, which patch causes failure. They should
be appliable on the current next.

Thanks,

Maciej Purski

Maciej Purski (7):
  regulator: core: Add debug messages
  regulator: core: Add regulator_set_voltage_rdev()
  regulator: core: Use re-entrant locks
  regulator: core: Implement voltage balancing algorithm
  regulator: core: Lock dependent regulators
  regulator: core: Lock dependent regulators on regulator_enable()
  regulator: core: Enable voltage balancing

 drivers/regulator/core.c | 341 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 300 insertions(+), 41 deletions(-)

-- 
2.7.4
