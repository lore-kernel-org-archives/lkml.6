Return-Path: <david@lang.hm>
X-Google-Smtp-Source: AB8JxZpe5/ztuulrtZQMJZUUh/vwb9IpxnyghWG03olt8DQKbe5tGqg3Jpl1CK9trxGpbciuAbPI
ARC-Seal: i=1; a=rsa-sha256; t=1525813195; cv=none;
        d=google.com; s=arc-20160816;
        b=0edCUVSy51eecZAEe6ekf5MJs8KqfiPRR8+2ZTF/nYyuLHkyvSfQ6iQFIeCiVqjgGZ
         x07gnLfI9M/RsVbWBe7DXqc24166eB6ZcFCDqJTyG4udqZ4Gk5vNwnVeR3X3WCIChxg9
         3zW+I9WaXFVpI9eT/zxY8OjVqALYf55b3gx0UqloU7VBLbrqXwA9/l9r36qacan1TkUl
         EorVbAOU0ZfGwQrrVt22GtVL7gzFxjYjJ4agT5o89x63Z7g5+C5bxvZ4cZqu0Kr+ICX+
         JGzw0uUh2D6fm/Dn1gKL5dkZKFAdCvrk2pus10fe1miLOfPSAIoxWm6BItY8hChNeVX4
         gPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=ptW7r942vVpFK/jymESFdy/s9VPRqEB9E2PAes7yykg=;
        b=ouea4LeubkrRWmV/YKdTOGJ79Gf0LFsi/DQVwDxkiKTatia+9fyBc6fwOjubyCHuJd
         JQfHXO2Q4c0pQrIAkRVfu8R7nOOEqi8UnsuCcSJEkNSCY+3MEeMkZcujTgAdlBE43+Hu
         wGbF0p9oOv2+U7/eEm9sZ8SQ+4KNNw8ovZcgjbH7Bj9CxmtvIeKiheIeO5/PwAIwYmks
         pY/DKmglYRuUfFzX0oaetlrWqYVQV6A7oUim2Yfb+6c4bfaKjgWOLokAPu3HqwgbBZ7u
         gSx3FDkTud8T8Lw9yLxs4pkH9doQHTY+GvnO7JjDrumk+zkDG/Q69gYoHmelj3/1HQX6
         CBaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of david@lang.hm designates 66.167.227.134 as permitted sender) smtp.mailfrom=david@lang.hm
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of david@lang.hm designates 66.167.227.134 as permitted sender) smtp.mailfrom=david@lang.hm
Date: Tue, 8 May 2018 13:59:18 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Matthew Wilcox <willy6545@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [Ksummit-discuss] bug-introducing patches
In-Reply-To: <20180508205505.GD8514@sasha-vm>
Message-ID: <alpine.DEB.2.02.1805081357451.31825@nftneq.ynat.uz>
References: <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk> <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net> <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org> <20180508202912.GC8514@sasha-vm> <CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com> <20180508205505.GD8514@sasha-vm>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599931097258751222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018, Sasha Levin wrote:

> There's no one, for example, who picked up vanilla v4.16 and plans to
> keep using it for a year.

Actually, at a prior job I would do almost exactly that.

I never intended to go a year without updating, but it would happen if nothing 
came up that was related to the hardware/features I was running.

so 'no one uses the Linus kernel is false.
