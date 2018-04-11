Return-Path: <dhowells@redhat.com>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477361-2-1591218082038810631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='66.187.233.73', Host='mx3-rdu2.redhat.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: dhowells@redhat.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477360; b=f+86JL/Yqe22As1SJSXb1V7B78drrQ45tHoa5xSnAvNUmEIL03
    52kEOXeVrDGKJk/u+hz2paf7LhaMpFnMvXwDStjc5xONdT6b1/tgXtCKhNB5MfAb
    EadjRkZXBj2wDctoz8ZHetLZVtWV+shwGIy4QasrZZQ2NjrU0b2oQD4dDNGvI22Z
    ++DxPl76CtlvhdK/OGIN1JvlShz9XmqFxmFkK9YVaPQSitZMLe8ZcdX+jzE+G+A4
    O1sLQdO0acP3BsASUpdno18+0UNgxfJJuTcHIQib/fubyMXgGNmAEcGsSTIHRkxp
    QlE6mAqTMwKC9A8T4+OW3ehRn760CIXLkRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id; s=fm2; t=
    1523477360; bh=ITTLYzP0m48ThZWr+eYvsFYOFbPMirzMUIihozz9bIA=; b=V
    Riw3RnWCvFXI0wBHmveYZoDZWzCi1bUJoiteZWVxOveFpjRXlmpRekg/y5JdxQ59
    k8/zxHSD+STYA/psmPRMbs56mxSMamH0WrqnYHrMUrzPJhAN7XSzwZ2Y6HKwKXcN
    T49D8nyxMqdlXzDeMQ+Jo5PLCS0j2xDhher3eoLGN7LwmKWjpCyO5L7sLGx95trb
    NYkCglpH6XH6sZ1RBXH4qNMZU14ThxQraw0x34lRRzN5agAkCNkQPQxIAz67qVjC
    u09eVugBT3X7QggHppQ523WDdejzaiQtkDd13xKQlCM/GJ3uTEEOO9cmpdPj65pH
    CvAcEYPL9gfdyMBgXQ8Vw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=pass (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=66.187.233.73 (mx3-rdu2.redhat.com);
    spf=pass smtp.mailfrom=dhowells@redhat.com smtp.helo=mx1.redhat.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=mx1.redhat.com x-ptr-lookup=mx3-rdu2.redhat.com;
    x-return-mx=pass smtp.domain=redhat.com smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=pass (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=66.187.233.73 (mx3-rdu2.redhat.com);
    spf=pass smtp.mailfrom=dhowells@redhat.com smtp.helo=mx1.redhat.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=mx1.redhat.com x-ptr-lookup=mx3-rdu2.redhat.com;
    x-return-mx=pass smtp.domain=redhat.com smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLtX3cHLCfYg4IWF3N7y0Op6UqJZrV9vaawUaPOaJhK4foOHnlfE1ExljZTU9LdkXcCkVkgUQjM/6zLYXjAVoO9QITQUWPpl6LmeYvDUuP1sNS7YaaH
    Bbm22IQ8ZVu7MfKjeK4HBvSt5HTyHkLyEjP4VXtUL3iEvarP3/OrcCu1cz32r2VfsABrgvnGFQLWbw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=TkcyNeq6r+AnHXJUTB3xOA==:117
    a=TkcyNeq6r+AnHXJUTB3xOA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=dhG99R2GNaa92lGwLz8A:9 a=CjuIK1q_8ugA:10
    a=yxGMNg53M24zlVSZdvMH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180411195436.GA7126@kroah.com>
References: <20180411195436.GA7126@kroah.com> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
To: Greg KH <greg@kroah.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
    linux-man@vger.kernel.org, linux-api@vger.kernel.org,
    jmorris@namei.org, linux-kernel@vger.kernel.org,
    linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12768.1523477356.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 21:09:16 +0100
Message-ID: <12769.1523477356@warthog.procyon.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg KH <greg@kroah.com> wrote:

> Why not just disable debugfs entirely?  This half-hearted way to sorta
> lock it down is odd, it is meant to not be there at all, nothing in your
> normal system should ever depend on it.
> 
> So again just don't allow it to be mounted at all, much simpler and more
> obvious as to what is going on.

Yeah, I agree - and then I got complaints because it seems that it's been
abused to allow drivers and userspace components to communicate.

David
