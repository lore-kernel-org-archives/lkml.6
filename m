Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759267AbeD0UcN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:32:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759241AbeD0UcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:32:11 -0400
Date: Fri, 27 Apr 2018 23:31:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] bpf: btf: remove a couple conditions
Message-ID: <20180427203135.mjkqoofbanozxzkd@mwanda>
References: <20180427140459.GB19583@mwanda>
 <20180427172023.6japncdd3nbqauzn@kafai-mbp>
 <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
 <20180427193959.3nebosalgl3ch4mv@mwanda>
 <21126ae9-5178-5d09-679c-6bca57ad48e8@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21126ae9-5178-5d09-679c-6bca57ad48e8@iogearbox.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8876 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:21:17PM +0200, Daniel Borkmann wrote:
> On 04/27/2018 09:39 PM, Dan Carpenter wrote:
> > On Fri, Apr 27, 2018 at 10:55:46AM -0700, Martin KaFai Lau wrote:
> >> On Fri, Apr 27, 2018 at 10:20:25AM -0700, Martin KaFai Lau wrote:
> >>> On Fri, Apr 27, 2018 at 05:04:59PM +0300, Dan Carpenter wrote:
> >>>> We know "err" is zero so we can remove these and pull the code in one
> >>>> indent level.
> >>>>
> >>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>> Thanks for the simplification!
> >>>
> >>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> >> btw, it should be for bpf-next.  Please tag the subject with bpf-next when
> >> you respin. Thanks!
> 
> Dan, thanks a lot for your fixes! Please respin with addressing Martin's
> feedback when you get a chance.
> 

My understanding is that he'd prefer we just ignore the static checker
warning since it's a false positive.  Should I instead initialize the
size to zero or something just to silence it?

regards,
dan carpenter
