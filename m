Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AIpwx49rWeNsMTPrVuXiDgggBiK6IB69srO9e4Ulo93v2ShP8GaHTybLp0c4Ocvlzdyqk7dILNKs
ARC-Seal: i=1; a=rsa-sha256; t=1522457172; cv=none;
        d=google.com; s=arc-20160816;
        b=poZnopyfBUd+ISkyP1kIfz6h0KLNHNeZakZn8AmOYbRO9vZMk4zMJJ4acaT8aoIi7o
         nOr5d4CeFSSGLpyjAJkyTFVZWoyPdimDTytOX2JNnolncozh1ecPNFBKiOuhIM7tkBmX
         31lSHkVzHF1/OVYjj9KxldjI6nUxYvtEv5zJBUctmJbBSN/IehIiSwH2iIC/QwR2pyjk
         F5YhWYBPtvf5IcbhvTW3lgn7DIjVVv/9WPqsL7LN2oKG3kvDQhJ6BzEuk65jpWyfpnhP
         rSmwG80g7ij1ZeLgJSwaypeUtcgcZf/PaJEeMRdZK1r+iB5w/U7ZR+dPt4ef/HszbkqL
         Eqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=BC+Tj1IkJGJHf16OXOir1ZUY1HhoNo+i1LEv7Wsb7DA=;
        b=HVqPmriG4V7N4K2ttTggbAI0rynYZ0jds7rtQkVRL3TTuloZsGUgZXu17w5KPM2nwo
         fkYlWCGreaQKfek68rjb7n7kIP2Md+l0PZrmZKK5DjaaihYgS2LqJF65XqrA6atxgefq
         XVlfwGd4GbIJaoN34QlihXqe++RoLuKcukoaC/uG5+yamCU8BHw0uR+dT8fgT0K2vPjL
         XBiF+OUVtvb1E3BEsC2DIES5n5eYQa6V30rILS7CL8VP19EfDV9iwsJ18RdkMgfP7v4m
         bfUkm173mX8RDLweEG0LMP3q46BJAFJRdmI0j9q1mUW34CkQPi6R7G0YAo2fzYB8Z4ib
         Ocvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Sat, 31 Mar 2018 11:46:10 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: gnomes@lxorguk.ukuu.org.uk, linux-efi@vger.kernel.org, mjg59@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <4136.1522452584@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1803311145180.7769@namei.org>
References: <4136.1522452584@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596412052034757798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 31 Mar 2018, David Howells wrote:

> Date: Thu, 26 Oct 2017 17:37:38 +0100
> 
> Hi James,
> 
> Can you pull this patchset into security/next please?  It has been in
> linux-next since the beginning of March.
> 
> It adds kernel lockdown support for EFI secure boot.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 
next-lockdown and next-testing

Are there any known coverage gaps now?



-- 
James Morris
<jmorris@namei.org>
