Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDPPad (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:30:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:40717 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeDPPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:30:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="32380115"
Date: Mon, 16 Apr 2018 21:05:01 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180416153501.GQ6014@localhost>
References: <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost>
 <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
 <CAMz4ku+EUtk2phRGkxkW6YwUvBLb-O7tmMoucvVEQZbL9EY8Zg@mail.gmail.com>
 <20180413034332.GI6014@localhost>
 <CAMz4kuL_i7u5OCXrtJy92=OisOzgbWk_e-S9dSuBRPenX=ScPA@mail.gmail.com>
 <20180413063641.GL6014@localhost>
 <CAMz4ku+dLk2Gi_20ATW5o-MPvpy-2iF_YJCwyStaH8xPNXSE7Q@mail.gmail.com>
 <20180416035831.GO6014@localhost>
 <CAMz4kuKbPZkJBF1ci5osntnHHD2nkm1d81=2GQohzc3KGn-wiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuKbPZkJBF1ci5osntnHHD2nkm1d81=2GQohzc3KGn-wiw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 02:32:05PM +0800, Baolin Wang wrote:

> >> Beside the general configuration, our audio driver will configure the
> >> fragment length, block length, maybe transaction length, and they must
> >> specify the request type and interrupt type, these are what we want to
> >> export for users.
> >
> > As I said before, you need to derive fragment, block or transaction from
> 
> I am sorry I did not make things clear here. What I mean is not only
> link list mode(prep_cyclic), but also other modes (prep_slave,
> prep_interleaved ...), users still need to configure the fragment
> length, block length or transaction length according to their
> requirements.

Other modes are similar, they also use the parameters programmed from
dma_slave_config. Pls see other driver examples. IIRC dw dma has
similar capabilities but not all are exposed to user and driver configures.

-- 
~Vinod
