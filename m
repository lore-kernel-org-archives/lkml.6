Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC3N7i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:59:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47316 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeC3N7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:59:37 -0400
Date: Fri, 30 Mar 2018 15:59:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: ARM Maintainers <arm@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] MAINTAINERS: update entry for ARM/berlin
Message-ID: <20180330135932.GB28244@lunn.ch>
References: <20180330110211.36455347@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330110211.36455347@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 11:02:11AM +0800, Jisheng Zhang wrote:
> Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
> So change the berlin entry name and move it to its alphabetical
> location. We move to ARM/Synaptics instead of ARM/Marvell.
> 
> This patch also updates my email address from marvell to synaptics.
> 
> [1] https://www.synaptics.com/company/news/conexant-marvell
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Thanks for the link

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Do you still plan to move the DT files from the Marvell subdirectory?
Are the locations of these files considered fixed?

    Andrew
