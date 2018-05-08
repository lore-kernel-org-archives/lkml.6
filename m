Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeEHK7H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:59:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:24586 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeEHK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:59:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180508105902epoutp02fa92d7a7da25f84c2e608cee4aad2eb9~spjocXdRz1774317743epoutp02H
X-AuditID: b6c32a4b-185ff70000001094-80-5af182f5bdb8
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc: sst2005@gmail.com, Satendra Singh Thakur <satendra.t@samsung.com>
Subject: Re: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
Date: Tue,  8 May 2018 16:28:30 +0530
Message-Id: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180507134602.GH12521@phenom.ffwll.local>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH++1u16u1us2Jv4xKrmYYOLe16bWyp8oiU6GgWIXe9Ncc7cXu
        fAWh+WpqWYJ/mApapJak0ZShq0X4SMzSJMlEyx5GGb1NCXtu3kn/fc/5fb7nnN/hEJjIigcQ
        WoMFmQ2MjsJ9+Pbu0NCw2fyvaqnjjxf9116B0SOzn3G6vmYpbXv9REA/dtTi9OOCYUBXDd3h
        0SXfq3G6ZaiITzcNjGI7fFTOuXq+qrP6mZdqsqyPp2q7kqsqb28Gqhnb2iRcjbamIyYNmQOR
        IdWYpjVooqm9+5N3JysjpLIwWRQdSQUaGD2KpmLik8LitDrXYFRgJqPLcKWSGJalwrdtNRsz
        LCgw3chaoqnDMplcIpNGSuRyuUShPLpZrnQhKSi9bngUM7WtyJ4ZfcnLA23LSoE3AUkF7Blu
        AaXAhxCRtwB8cN6KccE3ANunLvK5YA7AgTd3+YuWS62dAu7BCeD0/W8eahbAiodvBG4Kd1Fv
        a6sWKDFZxIPl+cN4KSAIjIyFDbUh7rwveRrA/GtvgdvAJ9fDZuck7tZCMg6Wv5ry4tqthWOD
        JZhbe5M0bH8/uVAUkh04fPTuJsZBMfBzYT7OaV/4vq/dYw6AM5+cOGcoAPBF6yUvLjgLoLXk
        nofaDgsr3b9zjxcKbzjCuXQ0rL1sXyiKkcvhuZ9TPDcCSSG0Fos4JBhee9eNLfb6VV8q4LQK
        jk885XF6J/x9vdez4jIAx0cbwQWwrvp/t3oAmsEqZGL1GsQqTZsMKEvCMno2w6CRpBr1NrBw
        hRv3dgDbYHwXIAlALRP+MH1RiwRMJpuj7wKQwCixMGjNV7VImMbknERmY7I5Q4fYLqB0rbYC
        C/BLNbpu2mBJlimipIqIiEiZVBqloPyFY/3P1SJSw1jQCYRMyLzo4xHeAXng2PSh7ISQIuLA
        ByIsZ2KGPNPn21p2lqpMVDTGaEfEQce03ccPpTDziYVZdh/HluD1qDJETffvWDfk39kQp9At
        ebKyZnejWNx/4UjcvqCksSv0mL04YSB2j5CZ12xYPnL5YzzoGazKrW5B3+enD5rrem3xp/yu
        7prkP2gKXb3zNsVn0xnZRszMMv8Acnr5K5sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnO6Xpo9RBqtOi1n83zaR2eLK1/ds
        Fgtmc1tsenyN1eLyrjlsFpebLzJazDi/j8mi88ssNou151tZLJafvs7swOWx99sCFo+ds+6y
        e9zvPs7ksXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlzL94nblgM3/F5+sPmRoYN/N0
        MXJySAiYSCxct5O1i5GLQ0hgN6PE2/m7mSASUhLL3mxjg7CFJVb+e84OUfSZUaLh71OwIjag
        7udzZoB1iwj0Mkk8Wr2BHSTBLOAucW/OLzBbWKBe4uqhVrAGFgFViVV774NN5RVwk+h79IQd
        YoOcxM1zncwgNqeAhcSWV/dZQWwhAXOJE1M3ME1g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4OLU0dzBeXhJ/iFGAg1GJh/dHwYcoIdbEsuLK3EOMEhzMSiK8yrIfo4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgVLWYYpbS/VN8
        Remaj0wtbPfFG1d47m3ZtHN+2B4N43Tulc7hh1f63568JVqLZ59/d/JcD4HNJ7N2OjAdtQ93
        yTncvmdmQl+B7qs1tTJHFwc+TNr6ZlvGsbJq76+yFRzNcotE5s5cyzTVpszk1VR+brd6qU+f
        a912G2XNyOeKm7tEZdHXi6qaSizFGYmGWsxFxYkAnHpoNUoCAAA=
X-CMS-MailID: 20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6
X-RootMTR: 20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6
References: <20180507134602.GH12521@phenom.ffwll.local>
        <CGME20180508105900epcas5p25ffe94a214e5ad0848d834d6c3562ad6@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2018 at 15:46:02 +0200, Daniel Vetter wrote:
> On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
> > 1.There is a function in drm-core to calculate display timing parameters:
> > horizontal front porch, back porch, sync length,
> > vertical front porch, back porch, sync length and
> > clock in Hz.
> > However, some drivers are still calculating these parameters themselves.
> > Therefore, there is a duplication of the code.
> > This patch series replaces this redundant code with the function
> > drm_display_mode_to_videomode.
> > This removes nearly 100 redundant lines from the related drivers.
> > 2.For some drivers (sun4i) the reverse helper
> > drm_display_mode_from_videomode is used.
> > 3.For some drivers it replaces arithmatic operators (*, /) with shifting
> > operators (>>, <<).
> > 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
> > 5.These changes apply to following crtc and encoder drivers:
> > atmel-hlcdc
> > bridge-tc358767
> > exynos-dsi
> > fsl-dcu
> > gma500-mdfld_dsi_dpi
> > hisilicon-kirin_dsi, ade
> > meson-encoder
> > pl111-display
> > sun4i-tv
> > ti lcdc
> > tegra dc
> > mediatek dpi dsi
> > bridge-adv7533
> 
> The drm_mode_to_videomode helper is meant for interop between drm and v4l,
> which have different internal structures to represent modes.
> 
> For drivers that only use drm I think the better option would be to add
> these fields to struct drm_display_mode as another set of crtc_* values
> (the computed values are stored in crtc_ prefixed members). And compute
> front/back porch in drm_mode_set_crtcinfo.
> 
> Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
> fields in all the drivers you're changing. This way you avoid having to
> change all the drm drivers to use v4l #defines.
> 
> Thanks,
> Daniel

Hi Daniel,
Thanks for the comments.
I will look into it.

Thanks
-Satendra
