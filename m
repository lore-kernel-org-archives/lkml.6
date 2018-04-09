Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523305524; cv=none;
        d=google.com; s=arc-20160816;
        b=C53kmSWo4sfIdd/KDAYddJwBx6oEU39ArP5vrg4ZJGQqYNRa+B8/6iCGhmQSbNnfOK
         UaN67LxTSaE/VSOHNkurv6rg03MJq4JmnfkWLGjfCteiDEE2VINABBAEZnbskegbDoAH
         CXsgoMr3ESzsCrrLn2lddrGkhClcTTqWt7wp44qBiMpbaGvPXp1bf8gz/AcloPjp+5zM
         qy0luUOlU14jfRCLcq0xAeMf7rWMFeJworI8/jXrL+SzcduV+YSxjarJsPJ2PQHuwfIM
         ypiPzWf3NiRppucI81FYx2lYi7p2E9hnh/SD84X70Hd+4brViEl4J9JoEYpRmpR1MXeq
         0ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=75LEPbVu5ri5dixdUFcrqokMMTlWbKwNBAa/U5hLSJ8=;
        b=LHiytXiRBkjyxkQ7aSMWe8bM2UviS0h6IG6zG3g2KngbeiotP+NJ8k58msykcySUzT
         pihfimIV9xrNaZjMojDoF3gix/nLICp9E647Vw4G9RQaLEPRrzBubBlgVT58Gmed+0Ff
         YeqYmVX/svAGFNuAupTeozShQp45PmfUflKWunFuCeo98RDTO+rnz28r3DPgCg467SxL
         n2lyPt2PM3f7KfPXKW8y1qmT4epgnt+yF5rP69/2YKaqrhuU4qHLFz0tdM7CI+K/3zVV
         eJgsvkYcOSB2nMYI+rcwd7ABwD0d+nUfXRcuOP97sH3LwFX5M33MVuQh66awLzm339R4
         pb3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx48FomVXSlJ734jW+1ELhDK0fFC3SLRr4Kp8HCPpaxmXxSg8pPdbWZjao/BQCREUXymoWLFlrw==
Date: Mon, 9 Apr 2018 15:25:22 -0500
From: Rob Herring <robh@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 08/10] dt-bindings: i3c: Document Cadence I3C master
 bindings
Message-ID: <20180409202522.x7pooixnfgz572jn@rob-hp-laptop>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-9-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-9-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347992501604184?=
X-GMAIL-MSGID: =?utf-8?q?1597301613370783304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:47:49AM +0200, Boris Brezillon wrote:
> Document Cadence I3C master DT bindings.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Fix example to match the new representation
> ---
>  .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

Reviewed-by: Rob Herring <robh@kernel.org>
