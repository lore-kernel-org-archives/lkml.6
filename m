Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AB8JxZoEQ1sRyeEIxV74Ia3a6aGTpvJUiyXorgyYAEJrzP0WsGjETMHQ/lYb3a9Z3GqW/VfRr/gm
ARC-Seal: i=1; a=rsa-sha256; t=1525348118; cv=none;
        d=google.com; s=arc-20160816;
        b=o+aKERZG63hE0ZrvyqpYMK63IH5DEpn59SBqV4DDlhfdQGKW5TA8QppD9g1D+pCSuy
         4lcKg8t35vFgnTT4vGeutFcWiol9qiDrHk0XtUO1kR1kNXIcXh2JiCFnoN35ZgQWKfWl
         EXjmTbZzhHjF/hyQze6j9HLnROVMeXODgAq2/e2dK6RbF5yFpNL8BS+djeiR27F777Yw
         x6JWyoOPSfB02QM492ly9ZLtx7XqWl9qhvh7+FM4FKPvdSPHJ4TC0eWoX/x97ofJMsr6
         mImZPf2YFLWkZgGXo8UsK0urBtlLaZs2Sq5PRa365tvFiUemY17FztmMOShHSTJVx7FC
         B1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:to:from:date
         :arc-authentication-results;
        bh=grIJ8lUDosfERFG5V+cC0AFxhsIgC2dPf/Er7KeIPIg=;
        b=PhS8Op10POUGqoEAgmDQsKu9rk1jt+GISSTQVTSROZdYP/PwazwCnE2fYyIoMYUmO7
         vftA62v+bkJ/Wtzh0jQpc0OdIkuO/XcBMvoL0kSYhvqIX4NL75f9q0dcvrypMAJNMGO4
         CoiZ9j2PWitSApm/d5qla4izZJMni2duTt4seeT+jvOfpu9p0Hm8jexkx3E/QLAo2sOU
         92I87vthqGhGesyL5b/I8Pm5EwO8AqBPSya/wjI71p7Qqk6VJAocAvTtoKEuIxCbHbRd
         zyI1k+z32B90GYRxmSRkTp0kVWlJIwGDqdcSzM4MzA/H6VLIWrTKc4dev2aW9WTZztym
         H7LA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Thu, 3 May 2018 12:48:34 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503114834.GZ30522@ZenIV.linux.org.uk>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503000620.GA29205@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599443429227327065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 08:06:20PM -0400, Theodore Y. Ts'o wrote:
 
> Because if that last is the case, then the prescription is very simple
> and not controversial --- bug fixes found post -rc4 should be held to
> the next merge window.

Provided it's not a known-to-be-exploited roothole, at least...
