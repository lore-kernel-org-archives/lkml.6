Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeEDTwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:52:01 -0400
Received: from namei.org ([65.99.196.166]:59462 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeEDTv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:51:59 -0400
Date: Sat, 5 May 2018 05:51:43 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: David Herrmann <dh.herrmann@gmail.com>
cc: linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        Casey Schaufler <casey@schaufler-ca.com>, davem@davemloft.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce LSM-hook for socketpair(2)
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
Message-ID: <alpine.LRH.2.21.1805050551020.30811@namei.org>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, David Herrmann wrote:

> Hi
> 
> This is v2 of the socketpair(2) LSM hook introduction.

Thanks, all applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>
