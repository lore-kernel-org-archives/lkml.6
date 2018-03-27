Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeC0N5K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:57:10 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34505 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeC0N5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:08 -0400
X-Google-Smtp-Source: AG47ELvMeNrMUdmGbad+FSmJ6Ipv/RwYVNQlv9mz7WIcQ15kcpOFw6UW75eCd7K8TKrDOlTjpJiEEw==
Date: Tue, 27 Mar 2018 06:57:05 -0700
From: Tejun Heo <tj@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] libata: ensure host is free'd on error exit paths
Message-ID: <20180327135705.GK1840639@devbig577.frc2.facebook.com>
References: <20180327132601.12749-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327132601.12749-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 02:26:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The host structure is not being kfree'd on two error exit paths
> leading to memory leaks. Add in new err_free label and kfree host.
> 
> Detected by CoverityScan, CID#1466103 ("Resource leak")
> 
> Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
