Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeENIk2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:40:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42723 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeENIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:40:12 -0400
X-Google-Smtp-Source: AB8JxZr/w6U/5bkVexElF/M5+HJ03mVs06qTw42+vuXUA8yQ3xmr9L06ubdVQnRgFA2kxikoI+9pRA==
Date: Mon, 14 May 2018 01:28:28 -0700
From: Olof Johansson <olof@lixom.net>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/2] ARM: SOC driver update v4.18
Message-ID: <20180514082828.ap52ygg3kxsdz26k@localhost>
References: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On Tue, May 08, 2018 at 02:41:36PM -0700, Santosh Shilimkar wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.18
> 
> for you to fetch changes up to 1e0a601437a6111ecf384df010812c53cada6497:
> 
>   firmware: ti_sci: Switch to SPDX Licensing (2018-05-04 23:10:23 -0700)
> 
> ----------------------------------------------------------------
> ARM: SOC driver update for 4.18
> 
>  - AEMIF driver update to support board files and remove
>    need of mach-davinci aemif code
>  - Use percpu counters for qmss datapath stats
>  - License update for TI SCI

Merged!


-Olof
