Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCWOyV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:54:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCWOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:54:20 -0400
Date: Fri, 23 Mar 2018 15:54:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        stuyoder@gmail.com, ruxandra.radulescu@nxp.com,
        razvan.stefanescu@nxp.com, Roy.Pledge@nxp.com, arnd@arndb.de
Subject: Re: [PATCH v2 0/6] bus: fsl-mc: enhance Management Complex userspace
 support
Message-ID: <20180323145418.GA21034@kroah.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521132659.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:05:30PM -0500, Ioana Ciornei wrote:
> This patch set adds restool support in fsl-mc bus along
> with a rescan attribute to the root DPRC container.
> 
> Changes in v2:
>  - changed mc_command in fsl_mc_command structure
>  - updated fsl_mc_command to use the proper types and moved it in uapi
>  - added proper sysfs documentation

I've applied patches 1 and 3 here, can you redo patch 2 and resend them
based on my tree?

thanks,

greg k-h
