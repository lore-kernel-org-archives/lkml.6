Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759014AbeD0Tkf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:40:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42624 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757592AbeD0Tkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:40:33 -0400
Date: Fri, 27 Apr 2018 22:39:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Martin KaFai Lau <kafai@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] bpf: btf: remove a couple conditions
Message-ID: <20180427193959.3nebosalgl3ch4mv@mwanda>
References: <20180427140459.GB19583@mwanda>
 <20180427172023.6japncdd3nbqauzn@kafai-mbp>
 <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8876 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=554
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:55:46AM -0700, Martin KaFai Lau wrote:
> On Fri, Apr 27, 2018 at 10:20:25AM -0700, Martin KaFai Lau wrote:
> > On Fri, Apr 27, 2018 at 05:04:59PM +0300, Dan Carpenter wrote:
> > > We know "err" is zero so we can remove these and pull the code in one
> > > indent level.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Thanks for the simplification!
> > 
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> btw, it should be for bpf-next.  Please tag the subject with bpf-next when
> you respin. Thanks!
>

I'm working against linux-next.  For networking, I have a separate tree
which I use to figure out if it's in net or net-next.  It's kind of a
headache (but obviously networking is the largest subtree so it's
required).

Is there an automated way to tie a Fixes tag from linux-next to a
subtree?

regards,
dan carpenter
