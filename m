Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2784231-1526395955-2-882445892780219869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526395952; b=dsOeESO9yNBFHo/oepJ+PLVIjtOB1xN67l3JukK9Qes7VFzLMk
    6T3mTUOCSxuchTANXEQudM6K04hmu3YA7mXx+LMjxtTpKEYZR/6fmqn4VxNvhrCR
    yz/iHodFYsU8jtuEJShztCK17nuhGcgmCx4g+AwArE6d+48CtFGjzOpCGxLOa0/u
    9JxnStAvxcEIT3iQpeGaIMADKM8iksi7fIgyHmhSUilhRvWoA+/RFWmW9/Bf9eJT
    +byqqsZB2FS9DdsBPgWkz2yDjTH3fldhwzbnJd7Q7a8qhYHwtQVPOq5E0Kpj7HG7
    JbR6bnttlYTtMaapy1CgEqdwDevODS4u8IKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526395952; bh=FQa5W
    MEqGCTwzdza4o1oZDLT5wMZhXA1ltM0xuWFNAs=; b=c0a5KtVFqAN6iUkKBmH8q
    9JorDj3iNitmrRDQ5f0nnujJuBtSzgqN/SIbVgxowvr0Pc2hShz5xtOZ4tdhavgy
    IKJnpRiOixR81cnoOS4ECh7x+XzzMqGA9JB81SPjC32Re1m4o0RwfqIFP+WamMZ1
    wqU7mKeNswxYDTD8c6y5bAycfyv7xWK1smvluexqJEPXhSxOm3saRLbUD3TF8Zco
    uC13zO2wRC17XmRG4G6//8/fa36BS3gP00xjUOMQFpN/yOWYP9FszgS5w1posKTe
    0497s8TXut01eNOT1UJ0KZSH8NHW92QG2APax1fg52haqECjHBa4QewdQI1z+ESs
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOpkVQX9UFS83FrXgPoHFbLStZIxaA8C8Up7bBg9zJaeI6NtZ0/82r2VUFA6eBA+pBcjDzAqNHTb3k9dkG0jr3KZad+79tuciGtctxNRCe1OvV6gXj7C
    g/0DTeL6+yqREn6Ioo6wjvGRu+ONl62ItOZoWCgq9sBq645v+DOOKWUgEj20pL4+XtPS8cmhmkQr8qdGL8fG8zFPrmrfmCmRbtdOjhG0wzeXnY+EptcmEsJz
    fYzDDAW1PwFv93UhxFqTVQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=tUDMEpiq_PVMli1CD90A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 16:56:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
Message-ID: <20180515145643.GA661@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878t8y46sy.fsf@xmission.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-afs@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 07:37:33AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > The shole seq_file sequence already operates under a single RCU lock pair,
> > so move the pid namespace lookup into it, and stop grabbing a reference
> > and remove all kinds of boilerplate code.
> 
> This is wrong.
> 
> Move task_active_pid_ns(current) from open to seq_start actually means
> that the results if you pass this proc file between callers the results
> will change.  So this breaks file descriptor passing.
> 
> Open is a bad place to access current.  In the middle of read/write is
> broken.
> 
> 
> In this particular instance looking up the pid namespace with
> task_active_pid_ns was a personal brain fart.  What the code should be
> doing (with an appropriate helper) is:
> 
> struct pid_namespace *pid_ns = inode->i_sb->s_fs_info;
> 
> Because each mount of proc is bound to a pid namespace.  Looking up the
> pid namespace from the super_block is a much better way to go.

What do you have in mind for the helper?  For now I've thrown it in
opencoded into my working tree, but I'd be glad to add a helper.

struct pid_namespace *proc_pid_namespace(struct inode *inode)
{
	// maybe warn on for s_magic not on procfs??
	return inode->i_sb->s_fs_info;
}

?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
