Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeBGNE3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:04:29 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27051 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbeBGNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:04:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180207130424epoutp01a8ebb059d23d9d8128f9f49f988c8c1a~RDNZ2igXZ1589215892epoutp01C
X-AuditID: b6c32a47-19fff7000000100c-47-5a7af9572876
Subject: Re: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <086b44d2-6556-fa7c-1a5b-01c243bf0682@samsung.com>
Date: Wed, 07 Feb 2018 14:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <5A7AE1E0.8000509@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7bCmhW74z6oog5srNC02zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4sfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZfR82c1e0MZSsW7TfcYGxonMXYycHBICJhJH1p4B
        srk4hAR2MErs6/vLCOF8Z5Q4sf0eXNWJL/ugqnYzSmzufs0C4dxnlPjxbT4jSJWwQLzEvocn
        2UFsEQENiZl/r4CNYhZ4yyix/tQksFFsAoYSvUf7wBp4Bewklh99zwpiswioSjxd0QfWLCoQ
        IbFw6lOoGkGJH5PvsYDYnALaErtnPACrYRbQlHjxZRILhC0ucez+TUYIW15i85q3UGdfZ5M4
        eMegi5EDyHaRaFpRBBEWlnh1fAs7hC0t8WzVRrA7JQT6gV5e0wzlzGCUuNM+gQmiylri8PGL
        rBAL+CQ6Dv9lhxjKK9HRJgRR4iHx5dx0VgjbUeL9vwXQEGplkrhyeR7zBEa5WUj+mYXkh1lI
        fpiF5IcFjCyrGMVSC4pz01OLjQqM9YoTc4tL89L1kvNzNzGCE42W+w7Gbed8DjEKcDAq8fAa
        bKiMEmJNLCuuzD3EKMHBrCTC+3NlVZQQb0piZVVqUX58UWlOavEhRmkOFiVx3tYAlyghgfTE
        ktTs1NSC1CKYLBMHp1QDY+w/mf2KLXfSMusstk9y5j7Cp7XCemnj5k13im8UPf/D+NHKdXZJ
        D3OxuvLxiatyDv0/wnb9ZoyNrohMivOGeK+isy3F1cEPD/Xkvj9/rOb+lrAV2lKqdxccyPm5
        /8TWvn9mVju8J4ZyCrSFXWjXFH5ZnvbD5J1i7cq/vJ//C8Vu3BXX7eSapcRSnJFoqMVcVJwI
        AMJLS0wwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jAd3wn1VRBhtnCltsnLGe1eL6l+es
        FpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhY/znSzOHB6vL/Ryu5xua+XyWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgyuj5spu9oI2lYt2m+4wNjBOZuxg5OSQETCROfNkH
        ZgsJ7GSUuDI7DMJ+yChx96MriC0sEC+x7+FJdhBbREBDYubfK4xdjFwczAJvGSXerIRpbmWS
        OPJdCcRmEzCU6D3axwhi8wrYSSw/+p4VxGYRUJV4uqIPbJCoQIRE58r5LBA1ghI/Jt8DszkF
        tCV2z3gAVMMBtEBdYsqUXJAws4C4xLH7NxkhbHmJzWveMk9gFJiFpHsWQscsJB2zkHQsYGRZ
        xSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGBHbDmv172B8vCT+EKMAB6MSD6/Bhsoo
        IdbEsuLK3EOMEhzMSiK8P1dWRQnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgnHtN84JjOlMz3z375Te32XUWSn1YfWd/gdcXfjWT/R5zkvZLhVrcrXk+
        bZWYplWoZk6vxjrRW3Nqzj/Ylfv1TDzndG9hrovizgIVeXwHSioCFUpyHpz6cWRRZf/de7bO
        vyN33PWvZ1+kNmvZ7Ohs1ZdLSyXXrJ5gcsXOJnKqQ/nDI8vvHd5wSImlOCPRUIu5qDgRAP4M
        HWuEAgAA
X-CMS-MailID: 20180207130423epcas2p44591f17faf5283758bded97b276ae2c2
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
        <20180205142230.9755-1-s.nawrocki@samsung.com>
        <5A7916A2.7010307@samsung.com>
        <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
        <5A7AE1E0.8000509@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 12:24 PM, Chanwoo Choi wrote:
> Could you share your equation?
> because your result is a little bit different of my result.
> - my equation : ((mdiv + kdiv/65535) x 24MHz) / (pdiv x POWER(2,sdiv))

It resembles the code from samsung_pll36xx_recalc_rate():

(24 * 10^6 * (M * 2^16 + K)) / (P * 2^S) / 2^16

and a more accurate one

ROUNDDOWN(ROUNDDOWN(24 * 10^6 * (M * 2^16 + K), 0) / ROUNDDOWN(P * 2^S, 0) / 2^16, 0)

Shouldn't you substitute 65535 with 65536?

-- 
Regards,
Sylwester
