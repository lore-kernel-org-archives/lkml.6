Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524477601; cv=none;
        d=google.com; s=arc-20160816;
        b=pz6evdbVH7PSoHZ2I3W6OFIY6G6PJzUoqJXUrCJ9gY2jRiXkQBJ+NeD7ui4hZjWc0R
         +ES+psW4ZfHIPl5AO3utvdPabG1LHhxP+cbYgRLfF36Ny8pCt+vPjtOlGnE47TEFAcRY
         tmDFSy/WsS3cOG7ouDpVY+5Qrv+lwA3+q0DJ/ksBuVvAPqslqIwOlcPtBP1PgiO3F1Sq
         x4QbvRcD96i7M5FO9oDP5T0RbpgHZEi6H4sI9lM+Jq2gGCfkEJQaAfyRWk5twJsZvt+S
         sFUV/RWbvQKznf3gRGuRQSkOLsuZ48aIhrGjyqKGs2oD8sn1UNWcGJUeHflqwqXTshYU
         1bTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YqY7mCr1ZEsu/NYIMD8o24TBYSwImbTbqkdNvEFGWlo=;
        b=lQcJdJRwZOKo3jZHwF+L/wv+dROkCRRsH3qDNYqK3CcrwTnr51sBccYbmbfyuq26SV
         r4CL/43syBqzhk3Q0E9GfWMI50pWfijWX9GSRIL9Fg1eGSZa2Fg7HdNSoOkL0oKMNkXc
         MBc2VDneW9xlUxYOrtVtKsasS/tWcLysDwXLG4ljCd5uxCFUV1Akxykdmafl+7n6KHiz
         Cd+uFaizKyyCwr2L/DkafzE+NUcYODHfXKnc08VkV2BijPwUCkQINCT+IHBBhSQbZ40J
         9j/IJum53sLB650wrlBSBlTianm6/m0VXBUiw7Q2VLWrMm9Iy8EHuMFEx0CEukwg472k
         kkNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KddB+tPM;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KddB+tPM;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx487PBBAeH9dCVGBjU/yix9IDt+JUiIo3qDcDRRyD7m/8WhBKglPEZhg5GQ22Xzdh3sEd6/lz423sDu8yRxIBYs=
MIME-Version: 1.0
In-Reply-To: <20180423091812.GB14322@kroah.com>
References: <20180416151121.GA26791@jordon-HP-15-Notebook-PC> <20180423091812.GB14322@kroah.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 23 Apr 2018 15:30:00 +0530
Message-ID: <CAFqt6zZc50b6oeJhau0=-winrqsnxrKjFB7gFLxgwQqp70Dh5A@mail.gmail.com>
Subject: Re: [PATCH] android: binder: Change return type to vm_fault_t
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arve@android.com, tkjos@android.com, maco@android.com,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597915915131087032?=
X-GMAIL-MSGID: =?utf-8?q?1598530625185226040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 2:48 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Apr 16, 2018 at 08:41:21PM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler
>> in struct vm_operations_struct. For now, this is
>> just documenting that the function returns a
>> VM_FAULT value rather than an errno.  Once all
>> instances are converted, vm_fault_t will become
>> a distinct type.
>>
>> Reference commit id->
>> 1c8f422059ae5da07db7406ab916203f9417e396
>
> As you know, that is not how you reference git commit ids.  Please fix
> up and resend.

Sure, I will send v2.
