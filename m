Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeCSK3g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:29:36 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32252 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbeCSK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:29:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180319102929epoutp02554f4f5131816952202a8a5a211e747b~dS5j69Z4T2704127041epoutp02x
X-AuditID: b6c32a38-ac3ff70000001054-96-5aaf9108199d
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
Date: Mon, 19 Mar 2018 11:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180318153512.8343-1-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7bCmvi7HxPVRBucPSFpcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs1h6/SKTReveI+wWF1d8YXLg9NjwuYnNY828NYweO2fd
        ZffYtKqTzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyXqyazFLQy1mxbMJ+1gbGzexdjJwc
        EgImEtdP/mPuYuTiEBLYwSixc8IVKOc7o8SMrUtYYaomd5xmgUhsAEqsuckCkhASuA/kLHIH
        sYUFQiU+zv8IFhcR0JS4/vc7WDOzwAQmif3bVEBsNgFDid6jfYwgNq+AncSMO//A6lkEVCXW
        v7rODGKLCkRILJz6FKpGUOLH5HtgNZxAR1xoe8kCMVNT4sWXSVC2uMSx+zcZIWx5ic1r3oJ9
        ICHwmk2i8eUvFogPXCTaX9yB+llY4tXxLUA2B5AtLXHpqC1EuFqis62LHaK3hVHiz7RLbBAJ
        a4nDxy9CPcMn8e5rDytEL69ER5sQRImHxOx9e6DGO0o0H1vABAmsdkaJy5tOs09glJuF5J9Z
        SH6YheSHWUh+WMDIsopRLLWgODc9tdiwwESvODG3uDQvXS85P3cTIzjlaFnsYNxzzucQowAH
        oxIPr8PRdVFCrIllxZW5hxglOJiVRHifXgEK8aYkVlalFuXHF5XmpBYfYpTmYFES5w0IcIkS
        EkhPLEnNTk0tSC2CyTJxcEo1MCa51fVezbW02lWgVzH3RWOE5N1FspMmc3RF9hX/mKygHt9t
        Ja17iC9zQvDe6jcd+U1r8lZfPV1yo/DJzEdOUq/r1JTkH18OWWqv1z9vpvKZEuk4O6f++/4M
        Qt0PLsY+X+9VzZM06elWrY/OX9TLFm79LHjjjuBK8wK/j69Zyqz8+2ds/fHoqhJLcUaioRZz
        UXEiACIqUss1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t9jQV32ieujDJ6eV7O4cvEQk8XUh0/Y
        LOYfOcdqcf78BnaLb1c6mCwu75rDZrH0+kUmi9a9R9gtLq74wuTA6bHhcxObx5p5axg9ds66
        y+6xaVUnm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBlvFg1maWgl7Ni2YT9rA2Mm9m7GDk5
        JARMJCZ3nGbpYuTiEBJYxyjx4scUdgjnIaPE+Q8LmUCqhAVCJT7O/8gCYosIaEpc//udFcQW
        EjCW+PD5ERtIA7PABCaJA22NbCAJNgFDid6jfYwgNq+AncSMO//AmlkEVCXWv7rODGKLCkRI
        dK6czwJRIyjxY/I9MJsT6KQLbS+BbA6goeoSU6bkgoSZBcQljt2/yQhhy0tsXvOWeQKjwCwk
        3bMQOmYh6ZiFpGMBI8sqRsnUguLc9NxiowLDvNRyveLE3OLSvHS95PzcTYzAGNl2WKtvB+P9
        JfGHGAU4GJV4eB2OrosSYk0sK67MPcQowcGsJML79ApQiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkb9VbNrXuVUbnNsmfSt7+yhHcsdfi5ze8k2ed3H
        jTlRvHv/OEdX3Qptu+PaxfXk5VaP9d5NCeqvZKZb7Ci9X356n/qsY0d+H921xrvYfG9SbqDc
        B40tutvUVs185Wl59mTipJu894VnvVbQL25/6BH2N4TZtfzh2ZVJs74bT8ozSb/7b5mhfdtZ
        JZbijERDLeai4kQA0IcocI0CAAA=
X-CMS-MailID: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
X-RootMTR: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
References: <20180318153512.8343-1-krzk@kernel.org>
        <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
> Compatible for XU4 audio is not being used.  Instead the board uses the
> same compatible as XU3.  The devices are now just compatible so they
> should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
> deprecated so in this future could be removed to limit useless
> properties.

It doesn't feel right to obsolete the "hardkernel,odroid-xu4-audio"
compatible, there is significant difference between XU3 and XU4 - there
is no audio CODEC on XU4, this board only supports audio over HDMI interface.
XU4 could be compatible with XU3, but not the other way around.
It just happens we have other DT properties that help to handle such HW 
design difference.

Moreover, only XU4 is still in production and should be in few more years [1], 
others are obsoleted now.

So I think we should keep at least these 2 compatible strings:

- "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
- "hardkernel,odroid-xu4-audio" - for boards without audio CODEC, 
   supporting only HDMI interface.

--
Thanks,
Sylwester

[1] https://com.odroid.com/sigong/blog/blog_list.php
