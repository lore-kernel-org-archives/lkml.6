Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030809AbeEYWb4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:31:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39587 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030743AbeEYWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:31:48 -0400
X-Google-Smtp-Source: ADUXVKJ5cTfqFE5f4tc8g579jnLp7Aun4ax5Yezg72PTtKMCp6Ox5wUII3/ONrTsCXapC4d4BXVjgQ==
Date: Fri, 25 May 2018 15:29:34 -0700
From: Olof Johansson <olof@lixom.net>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: Add the rtc enable clock for watchdog
Message-ID: <20180525222934.3trle7x4akape3kp@localhost>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
 <bc450ea82fe7fbec7e7f74c5cdc8a37d202fe526.1523846102.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc450ea82fe7fbec7e7f74c5cdc8a37d202fe526.1523846102.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:40:04AM +0800, Baolin Wang wrote:
> Add the rtc enable clock for watchdog controller to make it work well.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

APplied with "sprd: whale2:" added to the patch subject.


-Olof
