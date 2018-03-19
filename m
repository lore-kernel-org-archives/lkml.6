Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030228AbeCSRp5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:45:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967203AbeCSRpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:45:52 -0400
Message-ID: <1521481549.20208.8.camel@redhat.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Date: Mon, 19 Mar 2018 12:45:49 -0500
In-Reply-To: <20180319173356.GA28462@amd>
References: <20180318104023.GA10392@amd>
         <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
         <20180319092106.GA5683@amd> <1521474008.20208.2.camel@redhat.com>
         <20180319173356.GA28462@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 18:33 +0100, Pavel Machek wrote:
> On Mon 2018-03-19 10:40:08, Dan Williams wrote:
> > On Mon, 2018-03-19 at 10:21 +0100, Pavel Machek wrote:
> > > On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> > > > Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > With recent linux-next, after resume networkmanager often
> > > > > claims
> > > > > that
> > > > > "network is disabled". Sometimes suspend/resume clears that.
> > > > > 
> > > > > Any ideas? Does it work for you?
> > > > > 								
> > > > > 	
> > > > > Pavel
> > > > 
> > > > Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> > > 
> > > Thanks for testing... but yes, 4.16 should be ok. If not fixed,
> > > problem will appear in 4.17-rc1.
> > 
> > Where does the complaint occur?  In the GUI, or with nmcli, or
> > somewhere else?  Also, what's the output of "nmcli dev" after
> > resume?
> 
> In the GUI. I click in place where I'd select access point, and menu
> does not show up, telling me that "network is disabled".

Ok, what does 'nmcli dev' and 'nmcli radio' show?

Dan
