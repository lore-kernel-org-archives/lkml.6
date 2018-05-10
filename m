Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeEJTlB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:41:01 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35677 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEJTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:40:59 -0400
X-Google-Smtp-Source: AB8JxZrDahIUe9q4WxPcLq2A+uxxxpRyYB42pRzAeA/VAXSWoAp7hoxNTWciLxLu7H4MnameGpnJog==
Date: Thu, 10 May 2018 12:35:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/18] ptp: Remove pr_fmt duplicate logging prefixes
Message-ID: <20180510193500.rfnjgjffiksnceen@localhost>
References: <cover.1525964381.git.joe@perches.com>
 <5b315a623c63fd82df0540e27a130aaabd8c3b49.1525964385.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b315a623c63fd82df0540e27a130aaabd8c3b49.1525964385.git.joe@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:45:35AM -0700, Joe Perches wrote:
> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
