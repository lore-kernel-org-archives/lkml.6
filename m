Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeFDO1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:27:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753297AbeFDO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:27:40 -0400
Subject: Re: [Cluster-devel] [PATCH] MAINTAINERS: Add Andreas Gruenbacher as a
 maintainer for gfs2
To: Bob Peterson <rpeterso@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
References: <1511027539.39786658.1528121371637.JavaMail.zimbra@redhat.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <b19d6562-f33a-7a4a-176e-805c681f5ddc@redhat.com>
Date: Mon, 4 Jun 2018 15:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1511027539.39786658.1528121371637.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 04/06/18 15:09, Bob Peterson wrote:
> Add Andreas Gruenbacher as a maintainer for the gfs2 file system
>
> Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60179d948bb..f369e975c821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5941,6 +5941,7 @@ F:	scripts/get_maintainer.pl
>   GFS2 FILE SYSTEM
>   M:	Steven Whitehouse <swhiteho@redhat.com>
>   M:	Bob Peterson <rpeterso@redhat.com>
> +M:	Andreas Gruenbacher <agruenba@redhat.com>
>   L:	cluster-devel@redhat.com
>   W:	http://sources.redhat.com/cluster/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
>

You should also remove me at the same time. I'm still keeping an eye on 
the patches and so forth, but I can't claim to be maintaining gfs2 any 
more really,

Steve.
