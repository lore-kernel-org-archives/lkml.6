Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759317AbeD0V1g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:27:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757815AbeD0V1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:27:34 -0400
Date: Fri, 27 Apr 2018 14:26:50 -0700
From: Martin KaFai Lau <kafai@fb.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC: Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/2] bpf: btf: remove a couple conditions
Message-ID: <20180427212648.zskc5bk2hunkwvsg@kafai-mbp.dhcp.thefacebook.com>
References: <20180427140459.GB19583@mwanda>
 <20180427172023.6japncdd3nbqauzn@kafai-mbp>
 <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
 <20180427193959.3nebosalgl3ch4mv@mwanda>
 <21126ae9-5178-5d09-679c-6bca57ad48e8@iogearbox.net>
 <20180427203135.mjkqoofbanozxzkd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180427203135.mjkqoofbanozxzkd@mwanda>
User-Agent: NeoMutt/20171208
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:31:36PM +0300, Dan Carpenter wrote:
> On Fri, Apr 27, 2018 at 10:21:17PM +0200, Daniel Borkmann wrote:
> > On 04/27/2018 09:39 PM, Dan Carpenter wrote:
> > > On Fri, Apr 27, 2018 at 10:55:46AM -0700, Martin KaFai Lau wrote:
> > >> On Fri, Apr 27, 2018 at 10:20:25AM -0700, Martin KaFai Lau wrote:
> > >>> On Fri, Apr 27, 2018 at 05:04:59PM +0300, Dan Carpenter wrote:
> > >>>> We know "err" is zero so we can remove these and pull the code in one
> > >>>> indent level.
> > >>>>
> > >>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >>> Thanks for the simplification!
> > >>>
> > >>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> > >> btw, it should be for bpf-next.  Please tag the subject with bpf-next when
> > >> you respin. Thanks!
> > 
> > Dan, thanks a lot for your fixes! Please respin with addressing Martin's
> > feedback when you get a chance.
> > 
> 
> My understanding is that he'd prefer we just ignore the static checker
> warning since it's a false positive.
Right, I think patch 1 is not needed.  I would prefer to use a comment
in those cases.

> Should I instead initialize the
> size to zero or something just to silence it?
> 
> regards,
> dan carpenter
> 
