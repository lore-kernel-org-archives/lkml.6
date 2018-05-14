Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeENU6K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:58:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37585 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeENU6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:58:06 -0400
X-Google-Smtp-Source: AB8JxZrfN6hcY7vt0Tqhvcf0n24Rts0lFdzhisTh1UeZcf+rAW0cq1E6vmMz8WfC2ezrDD0w9IgBYQ==
Date: Mon, 14 May 2018 13:50:47 -0700
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/5] soc: samsung: Stuff for v4.18
Message-ID: <20180514205047.3ni3agyc3a2vwy67@localhost>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180513154238.22508-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513154238.22508-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 05:42:35PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-4.18
> 
> for you to fetch changes up to b2b568c591ddbb20d597e256212579d70dbf3000:
> 
>   soc: samsung: pm_domains: Deprecate support for clocks (2018-04-17 17:25:42 +0200)
> 
> ----------------------------------------------------------------
> Samsung soc drivers changes for v4.18
> 
> 1. Clock operations during power domain on/off were moved to respective
>    clock driver so clean up obsolete code from power domain driver.

Merged, thanks.


-Olof
