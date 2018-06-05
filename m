Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeFEIko (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeFEIkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:40:42 -0400
Date: Tue, 5 Jun 2018 10:40:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: mathias.nyman@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: remove the code build warning
Message-ID: <20180605084019.GA8665@kroah.com>
References: <1528216500-14172-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528216500-14172-1-git-send-email-gengdongjiu@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:35:00AM +0800, Dongjiu Geng wrote:
> Initialize the 'err' variate to remove the build warning,
> the warning is shown as below:
> 
> drivers/usb/host/xhci-tegra.c: In function ‘tegra_xusb_mbox_thread’:
> drivers/usb/host/xhci-tegra.c:552:6: warning: ‘err’ may be used uninitialized in this function [-Wuninitialized]
> drivers/usb/host/xhci-tegra.c:482:6: note: ‘err’ was declared here
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---

Any hint as to what commit caused this warning to show up?

thanks,

greg k-h
