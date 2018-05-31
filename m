Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeEaAKp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:10:45 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44001 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeEaAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:10:41 -0400
X-Google-Smtp-Source: ADUXVKLxPMeIt6Jr3hI4H9sIDIq8oaHiBElgHnAOSIPrl8C/5xI7yRFOKCb4sN6ofEIDHhk2JNBsRQ==
Date: Wed, 30 May 2018 19:10:38 -0500
From: Rob Herring <robh@kernel.org>
To: Li Wei <liwei213@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, khilman@baylibre.com, arnd@arndb.de,
        gregory.clement@free-electrons.com,
        thomas.petazzoni@free-electrons.com, yamada.masahiro@socionext.com,
        riku.voipio@linaro.org, treding@nvidia.com, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        zangleigang@hisilicon.com, gengjianfeng@hisilicon.com,
        guodong.xu@linaro.org, puck.chen@hisilicon.com, john.stultz@linaro.org,
        fengbaopeng@hisilicon.com
Subject: Re: [PATCH v10 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
Message-ID: <20180531001038.GA1081@rob-hp-laptop>
References: <20180525091712.37227-1-liwei213@huawei.com>
 <20180525091712.37227-3-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525091712.37227-3-liwei213@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 05:17:09PM +0800, Li Wei wrote:
> add ufs node document for Hisilicon.
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 41 ++++++++++++++++++++++
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      | 10 ++++--
>  2 files changed, 48 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
