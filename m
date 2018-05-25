Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030779AbeEYWbt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:31:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50896 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030730AbeEYWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:31:46 -0400
X-Google-Smtp-Source: ADUXVKL2tmOg8n77om1xzdQYN88BNohTb0luxp4hbAdqEv/8vgwB7tflgJrriQrs1wO+7fQXd2UWAA==
Date: Fri, 25 May 2018 15:29:09 -0700
From: Olof Johansson <olof@lixom.net>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: Add GPIO and GPIO keys device nodes
Message-ID: <20180525222909.sedcwcakptjoetma@localhost>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:40:03AM +0800, Baolin Wang wrote:
> This patch adds device nodes to enable one GPIO controller located on
> digital chip, 2 EIC (external interrupt controller) controllers loacted
> on PMIC and digital chip for Spreadtrum SC9860 platform.
> 
> Moreover this patch adds 3 GPIO keys relied on EIC controller to support
> power key and volume up/down keys.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied with "sprd:" added to the subject.


-Olof
