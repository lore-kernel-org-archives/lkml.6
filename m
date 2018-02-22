Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBVTUB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:20:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:58846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVTUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:20:00 -0500
Subject: Re: [PATCH] xen/pvcalls: fix null pointer dereference on map->sock
To: Colin King <colin.king@canonical.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180222172259.10381-1-colin.king@canonical.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ad17f925-bf95-967d-45d8-3248aea6ddcd@suse.com>
Date: Thu, 22 Feb 2018 20:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222172259.10381-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/18 18:22, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if map is null then a potential null pointer deference
> occurs when calling sock_release on map->sock.  I believe the
> actual intention was to call sock_release on sock instead. Fix
> this.
> 
> Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hmm, yes, kind of obvious. :-)

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
