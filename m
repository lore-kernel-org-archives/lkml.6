Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbeFDOkt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:40:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751782AbeFDOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:40:48 -0400
Subject: Re: [Cluster-devel] [PATCH v2] MAINTAINERS: Add Andreas Gruenbacher
 as a maintainer for gfs2
To: Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
References: <819640525.39798623.1528122982163.JavaMail.zimbra@redhat.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <4dc4458c-e469-66f8-0cd5-ef363bd0f8e5@redhat.com>
Date: Mon, 4 Jun 2018 15:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <819640525.39798623.1528122982163.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/18 15:36, Bob Peterson wrote:
> Add Andreas Gruenbacher as a maintainer for the gfs2 file system
> and remove Steve Whitehouse.
>
> Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60179d948bb..73745884a595 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5939,8 +5939,8 @@ S:	Maintained
>   F:	scripts/get_maintainer.pl
>   
>   GFS2 FILE SYSTEM
> -M:	Steven Whitehouse <swhiteho@redhat.com>
>   M:	Bob Peterson <rpeterso@redhat.com>
> +M:	Andreas Gruenbacher <agruenba@redhat.com>
>   L:	cluster-devel@redhat.com
>   W:	http://sources.redhat.com/cluster/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
>

Acked-by: Steven Whitehouse <swhiteho@redhat.com>
