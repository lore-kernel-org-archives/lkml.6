Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AG47ELtdxNRROxP7fGo1HKvUAzjgS7ZztOYFWVAUaLB46hxU92fUol2JpEF0OSBcbsbqQJMK94VN
ARC-Seal: i=1; a=rsa-sha256; t=1520628354; cv=none;
        d=google.com; s=arc-20160816;
        b=0i5w2pT6vLdWhS7xQvOpV7QvaB8wJtW+IpLUhBEfDSHZZaIfDzJt/IFbnBqjl+pwck
         k55MwsgZSpKhm6zRPo73JHyqmKdgxV8UxIHDckKWq5SVQfEZKfT9iL82U9a4HtrmUb6f
         iek6/WZzBib0TmmJe49682UhYM3hAvzP9p6otjqof5uql18VOOuqSBm1LM/8JX8gM/Rz
         8xgYHvoyjJ79AJAJoIdPMmjPWks4FewHn3Y5Lb8/nMFgZGYChbvrtQVemypoqTztmN10
         OP4dipsAX8mbfOCKPJWPJXP96dJY1ny+/7kotvb9GXneqDodeCCvo+bv3zX969W9959p
         5Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=qCeAP+x4t+kan3ATeUAJVxBVW/JMlVP86QBzAAJOfPg=;
        b=ueWSluLvmCfWTvCdtJe+yWlLHVSKxI7gM51O3GuFD9dUTC3urDDW/A5uR8kW+ZWjt8
         oC8KY3UMo0e1PK/jyxzg7w9jIGFxsnNbyNkNNu8bU1b8M1WzdEzbRIeYFN4JjY3OnqZm
         MbJLxk3ujlXxyNTbbNsbvJY2wI+pag6oFrjAqsOl9snLWZCQvRh8qCQn/dd+ga8dFgs6
         jCzTD2mrPxrvAnSSO6MIK7eXohEhlruf7sS2EXju+AEPwq9pS5jKu819l/MBbmztHgRB
         AOg4iYBjK+iBXI+87vD9jMVnrUBuNEpneNacS6wBux1FeE6pezyNeFvkq6QKhbgar4Pw
         JcXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Fri, 9 Mar 2018 20:45:26 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dan.j.williams@intel.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        aarcange@redhat.com, luto@kernel.org, keescook@google.com,
        tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        mark.rutland@arm.com
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
Message-ID: <20180309204526.56301f43@alans-desktop>
In-Reply-To: <20180307214624.D4361772@viggo.jf.intel.com>
References: <20180307214624.D4361772@viggo.jf.intel.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594494397029012995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 07 Mar 2018 13:46:24 -0800
Dave Hansen <dave.hansen@linux.intel.com> wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I think we need to soften the language a bit.  It might scare folks
> off, especially the:
> 
> 	 We prefer to fully disclose the bug as soon as possible.
> 
> which is not really the case.  Linus says:
> 
> 	It's not full disclosure, it's not coordinated disclosure,
> 	and it's not "no disclosure".  It's more like just "timely
> 	open fixes".
> 
> I changed a bit of the wording in here, but mostly to remove the word
> "disclosure" since it seems to mean very specific things to people
> that we do not mean here.
> 

If you want to be taken seriously then I think minimum you also need to
- Give a GPG key for messages to the list
- State what security is in place (encryption etc) to protect the list
  itself

There are probably a lot more things people would ask but given the
policy now clear that it's basically just an 'early tip off'/'make sure
Linus doesn't miss this' list for very short notification periods doesn't
matter so much.

Alan
