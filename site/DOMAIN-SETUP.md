# Custom Domain Setup for pdfpages.app

## 1. Configure DNS Records

Add these records at your domain registrar:

```
Type    Name    Value
────────────────────────────────────────────────
A       @       185.199.108.153
A       @       185.199.109.153
A       @       185.199.110.153
A       @       185.199.111.153
CNAME   www     wilmoore.github.io
```

## 2. Enable CNAME in the repo

```bash
cd site/public
mv CNAME.disabled CNAME
```

Then commit and push:

```bash
git add site/public/CNAME site/public/CNAME.disabled
git commit -m "chore: enable custom domain"
git push
```

## 3. Verify in GitHub

1. Go to https://github.com/wilmoore/pdfpages/settings/pages
2. Under "Custom domain", enter `pdfpages.app`
3. Click Save
4. Wait for DNS check to pass
5. Enable "Enforce HTTPS"

## 4. Verify

After DNS propagates (up to 24-48 hours):

```bash
curl -I https://pdfpages.app
```

Should return `HTTP/2 200`.
