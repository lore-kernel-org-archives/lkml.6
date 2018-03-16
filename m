Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvMGTz6gDESI8t4hQPXBEOZtCituD5gBCIXkE8moNwZeiBQlf0RsgZ8djEj8e9uEm8IOdmD
ARC-Seal: i=1; a=rsa-sha256; t=1521192685; cv=none;
        d=google.com; s=arc-20160816;
        b=DuzkwEOtGLGnTyD1qUwth1Q8PdbO355vZHC/5WbQOhErPomMegzaTeZomrznj89Khd
         UOLwMZOCUjpbdtRi+ggIvopFQeFl09mJZbJZ5ukzg82QqldHnj3XGkDOrxhfXA6b8Eow
         ZuXNnlEILesoo+QIptiEJYBVXCS5IbdFzr1QWlocR8xemDFM4ov+p4MXwvJdQwdTTucu
         p7Rw3ItJx87pdGY6b+h3qj6ayoYGSUhB7eZ7GpFOJrOztwn5H3QTpU6ASR2ZedWYIUZs
         oiqiAKl5wUjDGYvpo2xiSDuC3gm2pt5qe97jt6qlQaxXAZgVa9hHOBizNsP51yrYsM2V
         QHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2ChKmbtStbMs0IYsyt2UDNHo6cFlim1rFGVXCtREkqU=;
        b=t+0kGad4WPo/v6oaf8nQK3aEmppJF4uC5h62DvZbWyU0kVk0jmZSgItgLXH6FQnNtk
         AknDorra7cIEOLs6WPwoYOtRswU72d970USypVK1EPO1LnJrPf1Sou4unkZkd1dPZYZh
         sJWtTeel/UjlFeo+3O4d7qKcUjzkvPaZdx0umCfJqNfuERZqHD9P6riBHu5In76TivZ9
         VLlijeekFuH++s8tFRrOoFOcfD2aP7e7ZYrJr/kbYIZOep/5Y67IeFvsaV229Br9q/vo
         KBFAUerWJTBS5GFpBKJEm3ocewWtpBmhz1cR7Ph454aF2MbpIxW9EX+4kOzBOykFUFbj
         2vQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Date: Fri, 16 Mar 2018 10:31:21 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>, Nicholas
 Piggin <npiggin@gmail.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 linux-kernel@vger.kernel.org, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 0/9] powerpc barrier_nospec
Message-ID: <20180316103121.6dadf5b2@naga.suse.cz>
In-Reply-To: <20180316080810.GA29615@kroah.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
	<cover.1521141122.git.msuchanek@suse.de>
	<20180316080810.GA29615@kroah.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032344364253632?=
X-GMAIL-MSGID: =?utf-8?q?1595086141156909089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 09:08:10 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Mar 15, 2018 at 08:15:49PM +0100, Michal Suchanek wrote:
> > Yes, it is good idea to add some commit messages.  
> 
> Always a good idea :)
> 
> Also, any reason you are not tagging these for the stable release(s)?

Oh, right. cc:stable would be a good idea as well.

Thanks

Michal
