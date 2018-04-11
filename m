Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeDKKMS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:12:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:62116 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbeDKKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:12:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="31838931"
Date: Wed, 11 Apr 2018 18:15:29 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] tools/power turbostat: if --max_loop, print for
 specific time of loops
Message-ID: <20180411101529.GA12068@yu-chen.sh.intel.com>
References: <20180410145141.31166-1-yu.c.chen@intel.com>
 <1523438944.2753.207.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523438944.2753.207.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 12:29:04PM +0300, Artem Bityutskiy wrote:
> On Tue, 2018-04-10 at 22:51 +0800, Yu Chen wrote:
> > +		case 't':
> > +			{
> > +				int loops = strtod(optarg, NULL);
> > +
> > +				if (loops <= 0) {
> > +					fprintf(outf, "loops %d should be positive number\n",
> > +						iterations);
> > +					exit(2);
> > +				}
> > +				iterations = loops;
> > +			}
> 
> What is the point of the additional {} scope and the 'loops' variable
> in it? You could use the 'iterations' variable directly and simplify
> the code.
Got your point, will change it.
> 
> Artem.
