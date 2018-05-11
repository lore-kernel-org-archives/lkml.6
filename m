Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeEKHef (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbeEKHee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:34:34 -0400
Subject: Re: [PATCH v2 2/3] xen/store: do not store local values in
 xen_start_info
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
References: <20180509102129.14832-1-roger.pau@citrix.com>
 <20180509102129.14832-3-roger.pau@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ebfa8ef3-2009-1e7e-f5f1-c52a5b3f01eb@suse.com>
Date: Fri, 11 May 2018 09:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509102129.14832-3-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 12:21, Roger Pau Monne wrote:
> There's no need to store the xenstore page or event channel in
> xen_start_info if they are locally initialized.
> 
> This also fixes PVH local xenstore initialization due to the lack of
> xen_start_info in that case.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
