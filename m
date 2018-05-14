Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeENKc1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:32:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55465 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeENKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:32:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514103222epoutp015f089c7e77719345f2dd5e9bb452cb5a~ufEEQGzxm2371723717epoutp01H
X-AuditID: b6c32a38-6f7ff7000000105c-6e-5af965b3a57f
Mime-Version: 1.0
Subject: RE: [PATCH v4 0/6] devfreq: rk3399_dmc: improve rk3399_dmc driver
 and it's documentation
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180514103218epcms1p487dcebca93bacca64eca1775b2cd826d@epcms1p4>
Date: Mon, 14 May 2018 19:32:18 +0900
X-CMS-MailID: 20180514103218epcms1p487dcebca93bacca64eca1775b2cd826d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180514103218epcms1p487dcebca93bacca64eca1775b2cd826d
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmnu7m1J9RBjfWCVq8PKRpcf3Lc1aL
        V5v3sFnMP3KO1WLB9pVMFmtuH2K0OPVqGbPF/0evWS1+bDjFbLH5XA+rxdmmN+wWl3fNYbP4
        3HuE0WLp9YtMFq17j7BbHF8b7iDgsWbeGkaP2Q0XWTx23F3C6LFgU6nHplWdbB53ru1h8/g7
        az+LR9+WVYwe26/NY/b4vEkugCsq1SYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJc
        SSEvMTfVVsnFJ0DXLTMH6BMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1StKGhkZ6hgbme
        kRGQNo61MjIFKklIzbg9YRd7wQfWiglz9RsYr7F0MXJySAiYSNxYsoaxi5GLQ0hgB6PE09N3
        mboYOTh4BQQl/u4QBqkRFkiWWPVwCjuILSSgJNFwcx8zRFxfouPBNkYQm01AV2LrhrssIHNE
        BCYyShy73MYK4jALnGaRuNS7lgliG6/EjPanUJulJbYv3wrWzSngJHF+1Wp2iLioxM3Vb+Hs
        98fmM0LYIhKt984yQ9iCEg9+7oaKS0k8ebsQqr5e4vrnRUwgiyUEJjBK/L7xHyqhL/Hoymw2
        EJtXwFfi8Nv5rCA2i4CqxNTrz6AGuUjc2P8I7DhmAXmJ7W/nMINCgllAU2L9Ln2Y+xs2/mZH
        ZXMA2bYSG5oTITr5JN597WGFKdkx7wnU62oSh3YvgWqVkTg9fSHzBEblWYignoVk7yyEvQsY
        mVcxiqUWFOempxYbFpjoFSfmFpfmpesl5+duYgQnZy2LHYx7zvkcYhTgYFTi4Q1Y/iNKiDWx
        rLgy9xCjBAezkgjvbqOfUUK8KYmVValF+fFFpTmpxYcYTYHen8gsJZqcD8wceSXxhqZGxsbG
        FiaGZqaGhkrivHOUvkYJCaQnlqRmp6YWpBbB9DFxcEo1MPIrm0TM7CgJFvy3pOjLjd5NeWZn
        axZbG6ywyeSKdq7f8zVna45bn0jx0kYDrYUf/3MEhNpI6+XJ32iXS1YpZUhUStJSuZy/yjDg
        26PfS3/Vdotv/Vws9tyW/cr9KfdXSjZLBERfmvng1DuBB8aFZq95a36uvBj27qtw+0PDd7Zh
        Ri2Pn7d7KLEUZyQaajEXFScCACC/zqjkAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509125801epcas2p29e23003ce1111e20bfcb3bdc5db94372
X-RootMTR: 20180509125801epcas2p29e23003ce1111e20bfcb3bdc5db94372
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125801epcas2p29e23003ce1111e20bfcb3bdc5db94372@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Dear all,
>
>These patches is an attempt to improve a little bit the rk3399_dmc
>driver and it's documentation in order to have all in a better shape for
>a future work I am doing. My final intention is add ddrfreq support for
>rockchip drm driver, but the patches for this are still
>work-in-progress. So let's start with this first patchset that is
>basically some fixes/improvements for the rk3399_dmc driver.
>
>The patches apply on top of current 4.17-rc3.
>
>Best regards,
> Enric
>

Dear Enric,

It appears that this patchset is ready to be applied.

Is "dt-binding" part going to be merged separatedly?
Or may I handle all the 6 commits? (assuming the three dt-binding got acks from dt maintainers)

Cheers,
MyungJoo
