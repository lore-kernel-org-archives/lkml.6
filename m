Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeCIMu2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:50:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33821 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeCIMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:50:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180309125024euoutp02f5e0371684ce3c61e2fc291cd18e46b3~aQXvaIzZh0948909489euoutp027
X-AuditID: cbfec7f5-b45ff700000028a9-c8-5aa2830ec5db
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <5cf960c5-73ab-fd53-fb68-b6f7f92ca3e7@samsung.com>
Date: Fri, 09 Mar 2018 13:50:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180309124234.GC5252@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7p8zYuiDC59MrXYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvF2iN32S2WXr/IZNG69wi7xf4rXg7cHmvmrWH0
        +PZ1EovH7IaLLB47Z91l99i0qpPNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDLeTehgKTjO
        WrFq70emBsYVLF2MnBwSAiYS91bvYOti5OIQEljBKLF01UMo5zOjxLPmDlaYqrn3F0MlljFK
        XNrSwgjhPGOU+DbtBSNIlbCAjcSdl1vAOkQElCWuft/LAlLELNDELLFv3gOmLkYODjYBLYk1
        7fEgNbwCdhLTP15mB7FZBFQlDi06xgZiiwpESCyc+pQRokZQ4sfke2C3cgoYSRy/+RGsnlnA
        UeLBop2sELa4RHPrTRYIW15i85q3zCB7JQQ+s0lMmrMK6lEXiSvbt0LZwhKvjm9hh7BlJC5P
        7oaKV0tc/LqLDcKukWi8vQGqxlri86QtzBAL+CQmbZvODPKLhACvREebEESJh8StK2uZIGxH
        iaufZ0AD6AAwgKavY57AKDcLyT+zkPwwC8kPs5D8sICRZRWjeGppcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZgQjr97/jXHYz7/iQdYhTgYFTi4X3guDBKiDWxrLgy9xCjBAezkgjv+5pFUUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR54zTqooQE0hNLUrNTUwtSi2CyTBycUg2MqQvkH2SHxar/
        DOA9cEboiZ5nvG1fw9N4JTOzr092eQQacleKXT/rnHrb8sF3x4LulIh++ftfvorq7Wq8vCEi
        Tqbl2J/CBzEy3rJfns4T+DRV4Nz5jWGLnOaFtXb8vTfnwRLTnpcCB1NP7c/8rXJpXY19bsLP
        jZFrzjhm3ZxX8GHD0mXlrQYuSizFGYmGWsxFxYkAYfPyo0QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4ZV2+5kVRBu1/WCw2zljPajH14RM2
        i/lHzrFanF12kM3i4VV/i29XOpgsLu+aw2ax9shddoul1y8yWbTuPcJusf+KlwO3x5p5axg9
        vn2dxOIxu+Eii8fOWXfZPTat6mTz6NuyitHj8ya5APYoLpuU1JzMstQifbsErox3EzpYCo6z
        Vqza+5GpgXEFSxcjJ4eEgInE3PuL2boYuTiEBJYwSuyf+osRwnnGKDH12id2kCphARuJOy+3
        sILYIgLKEle/72UBKWIWaGGWOLT1JQtExyFGiU0r3gF1cHCwCWhJrGmPB2ngFbCTmP7xMtgg
        FgFViUOLjrGB2KICERKdK+ezQNQISvyYfA/M5hQwkjh+8yNYPbOArcSC9+tYIGxxiebWm1C2
        vMTmNW+ZJzAKzELSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGDfb
        jv3csoOx613wIUYBDkYlHt4HjgujhFgTy4orc4H+42BWEuF9X7MoSog3JbGyKrUoP76oNCe1
        +BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAOj2eFlzpGrJqmFS+qf0yjI7Lpzp3V+
        zeF2y/i1W6587MvO2rfQhk9UdRtfgc/T9cr5XIfZSg/WZd68HffaR0YvKWequHbClS6ZKxea
        nGLjBfUNjuolHfjvW3OJ9dXdPfLl5x9djf62c0PHG6fTcwpv+e90jtR69jj528VV+/e3b/uh
        2bu2IpVBiaU4I9FQi7moOBEAcgVmVJcCAAA=
X-CMS-MailID: 20180309125022eucas1p26cdf9df2d2a2f8a1460093b4d058d41d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
X-RootMTR: 20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
        <1520598128-11768-1-git-send-email-m.purski@samsung.com>
        <20180309124234.GC5252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 01:42 PM, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 01:22:02PM +0100, Maciej Purski wrote:
> 
>> I would like to kindly ask Fabio Estevam and Tony Lindgren to test the patch
>> series on their boards.
> 
> That'd be great, yeah - I can run some tests with kernelci as well,
> though the latency is relatively high there.
> 
> Is it possible to respin this in terms of the test/coupled branch in my
> git tree?  There were a bunch of build fixes that got sent and I don't
> want to loose any of those.
> 

I have included those build fixes in my new patchset. I can extract the newest 
changes and rebase them against your test/coupled branch, if that's what you're 
asking for.
