Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeEXX0D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:26:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:52436 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755048AbeEXX0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:26:01 -0400
Date: Thu, 24 May 2018 19:25:53 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180524232553.GI7712@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524221715.GY10363@dastard>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 08:17:15AM +1000, Dave Chinner wrote:
> On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Although the api is documented in the source code Ted has pointed out
> > that there is no mention in the core-api Documentation and there are
> > people looking there to find answers how to use a specific API.
> > 
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > Cc: David Sterba <dsterba@suse.cz>
> > Requested-by: "Theodore Y. Ts'o" <tytso@mit.edu>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Yay, Documentation! :)

Indeed, many thanks!!!

					- Ted
