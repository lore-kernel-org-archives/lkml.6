Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030526AbeEYVfu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:35:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33322 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030284AbeEYVfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:35:46 -0400
X-Google-Smtp-Source: ADUXVKLN72Z7CEI9+KKO/qBfs5odA8vEHbYyhNWtXofuOddlQBLEfXccmSIJu5z2h93iIY1NjIivFw==
Date: Fri, 25 May 2018 14:33:12 -0700
From: Olof Johansson <olof@lixom.net>
To: Andy Gross <andy.gross@linaro.org>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.18
Message-ID: <20180525213312.l4bdo72uidfcbrtg@localhost>
References: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:37:39PM -0500, Andy Gross wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.18
> 
> for you to fetch changes up to 57fc67ef0d35af11fbb1b928e359b370889994ae:
> 
>   arm64: dts: qcom: msm8996: Add ufs related nodes (2018-05-22 23:29:03 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.18
> 
> * Add support for SDM845 and associated peripherals
> * Fix gic_irq_domain_translation warnings on Qualcomm platforms
> * Add binding for GENI SE, Qualcomm bluetooth, and Command DB
> * Add support for SDHCI and ramoops on MSM8992
> * Fixup qcom,pcie devices to pcie
> * Add wlan, bluetooth, and micro SD supplies on db820c
> * Add UFS related nodes on MSM8996

Merged, thanks!


-Olof
