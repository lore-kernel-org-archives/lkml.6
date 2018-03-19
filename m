Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbeCSPkM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:40:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCSPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:40:11 -0400
Message-ID: <1521474008.20208.2.camel@redhat.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>, Woody Suwalski <terraluna977@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Date: Mon, 19 Mar 2018 10:40:08 -0500
In-Reply-To: <20180319092106.GA5683@amd>
References: <20180318104023.GA10392@amd>
         <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
         <20180319092106.GA5683@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 10:21 +0100, Pavel Machek wrote:
> On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> > Pavel Machek wrote:
> > > Hi!
> > > 
> > > With recent linux-next, after resume networkmanager often claims
> > > that
> > > "network is disabled". Sometimes suspend/resume clears that.
> > > 
> > > Any ideas? Does it work for you?
> > > 									
> > > Pavel
> > 
> > Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> 
> Thanks for testing... but yes, 4.16 should be ok. If not fixed,
> problem will appear in 4.17-rc1.

Where does the complaint occur?  In the GUI, or with nmcli, or
somewhere else?  Also, what's the output of "nmcli dev" after resume?

Dan
