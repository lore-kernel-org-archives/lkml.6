Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeDHPvR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 11:51:17 -0400
Received: from h2.hallyn.com ([78.46.35.8]:32964 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeDHPvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 11:51:16 -0400
Date: Sun, 8 Apr 2018 10:51:15 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: shinya1.takumi@toshiba.co.jp
Cc: serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 0/2] WhiteEgret LSM module
Message-ID: <20180408155114.GE9715@mail.hallyn.com>
References: <20180330083031.2199-1-masanobu2.koike@toshiba.co.jp>
 <20180401200827.GA28101@mail.hallyn.com>
 <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB21847D1D8A8BC8458CBAD39592BB0@OSBPR01MB2184.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shinya1.takumi@toshiba.co.jp (shinya1.takumi@toshiba.co.jp):
> I am one of developers of WhiteEgret.
> 
> > regardling the last one, do you have a plan for handling it?
> Yes, we have a plan to release WhiteEgret v4 patch with a WEUA sample of access control for script programs.

Do you have a target date for posting that?

> The latest WhiteEgret cannot control script programs since script files read by an interpreter are not hooked by the execve system call.
> We consider that script programs can be controlled by controlling the files inputted by interpreters, accordingly. 
> We consider that the control can be realized using the read system call hooking.

So you have a design for being able to differentiate the interpreters reading
versus reading with the intent to execute?  With or without their help?

> Now, we are developing WhiteEgret with the read system call hooking and WEUA which controls the script files to be read to interpreters using information from the read system call hooking and white list.

-serge
